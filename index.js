var assert = require("assert");
var fs = require("fs");
const js_yaml = require("js-yaml");

let res = null;
let mem = null;

setMemory = function (m) {
    mem = m;
};

var memset = function (mem, offset, data) {
        var asBytes = new Uint8Array(mem.buffer, offset, data.length);
            asBytes.set(data);
};
var memget = function (mem, offset, length) {
        return Buffer.from(new Uint8Array(mem.buffer, offset, length));
};


function getImports(env) {
    return {
        env: {
            eth2_blockDataCopy: function (ptr, offset, length) {
                memset(mem, ptr, env.blockData.slice(offset, offset + length));
            },
		    debug_printMemHex: function (ptr, length) {
				console.log('debug_printMemHex: ', ptr, length, memget(mem, ptr, length).toString('hex'))
		  	},  
            eth2_savePostStateRoot: function (ptr) {
                res = memget(mem, ptr, 32);
            },
		  	eth2_loadPreStateRoot: function(ptr) {
				memset(mem, ptr, env.preStateRoot)
		  	},  
		  	eth2_blockDataSize: function () {
				return env.blockData.byteLength
		  	},
        }
    };
}

function parseYaml(file) {
    var testCase = js_yaml.safeLoad(file);
    var scripts = testCase.beacon_state.execution_scripts;
    var shardBlocks = testCase.shard_blocks;
    var testCases = [];
    for (var i = 0; i < scripts.length; i++) {
        var script = scripts[i];
        var preStateRoot = Buffer.from(testCase.shard_pre_state.exec_env_states[i], 'hex');
        var postStateRoot = Buffer.from(testCase.shard_post_state.exec_env_states[i], 'hex');
        assert(preStateRoot.length === 32);
        assert(postStateRoot.length === 32);
        var blocks = [];
        for (var _i = 0, shardBlocks_1 = shardBlocks; _i < shardBlocks_1.length; _i++) {
            var b = shardBlocks_1[_i];
            if (parseInt(b.env, 10) === i) {
                blocks.push(Buffer.from(b.data, 'hex'));
            }
        }
        testCases.push({
            script: script,
            preStateRoot: preStateRoot,
            postStateRoot: postStateRoot,
            blocks: blocks
        });
    }
    return testCases;
}

function main() {
    var yamlPath;
    if (process.argv.length === 3) {
        yamlPath = process.argv[2];
    }
    else if (process.argv.length === 2) {
        yamlPath = 'test.yaml';
    }
    else {
        throw new Error('invalid args');
    }
    var yamlFile = fs.readFileSync(yamlPath, { encoding: 'utf8' });
    var testCases = parseYaml(yamlFile);
    for (var _i = 0, testCases_1 = testCases; _i < testCases_1.length; _i++) {
        var testCase = testCases_1[_i];
        var wasmFile = fs.readFileSync(testCase.script);
        var wasmModule = new WebAssembly.Module(wasmFile);
        var preStateRoot = testCase.preStateRoot;
        for (var _a = 0, _b = testCase.blocks; _a < _b.length; _a++) {
            var block = _b[_a];
            var instance = new WebAssembly.Instance(wasmModule, getImports({ preStateRoot: preStateRoot, blockData: block }));
            setMemory(instance.exports.memory);
            var t = process.hrtime();
            instance.exports.main();
            t = process.hrtime(t);
            console.log('benchmark took %d seconds and %d nanoseconds (%dms)', t[0], t[1], t[1] / 1000000);
            preStateRoot = res;
        }
        assert(testCase.postStateRoot.equals(res), "expected " + testCase.postStateRoot.toString('hex') + ", received " + res.toString('hex'));
    }
}
main();
