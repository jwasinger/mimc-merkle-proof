(module
 (type $FUNCSIG$vii (func (param i32 i32)))
 (type $FUNCSIG$vi (func (param i32)))
 (type $FUNCSIG$iiiiii (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $FUNCSIG$v (func))
 (type $FUNCSIG$i (func (result i32)))
 (type $FUNCSIG$viii (func (param i32 i32 i32)))
 (type $FUNCSIG$iii (func (param i32 i32) (result i32)))
 (type $FUNCSIG$ii (func (param i32) (result i32)))
 (type $FUNCSIG$viiii (func (param i32 i32 i32 i32)))
 (type $FUNCSIG$iiiiiiiiii (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))
 (import "watimports" "$g1m_toMontgomery" (func $websnark_bn128/bn128_g1m_toMontgomery (param i32 i32)))
 (import "watimports" "$g2m_toMontgomery" (func $websnark_bn128/bn128_g2m_toMontgomery (param i32 i32)))
 (import "watimports" "$g1m_neg" (func $websnark_bn128/bn128_g1m_neg (param i32 i32)))
 (import "watimports" "$ftm_one" (func $websnark_bn128/bn128_ftm_one (param i32)))
 (import "watimports" "$bn128_pairingEq2" (func $websnark_bn128/bn128_pairingEq2 (param i32 i32 i32 i32 i32) (result i32)))
 (import "env" "debug_printMemHex" (func $main/debug_mem (param i32 i32)))
 (import "env" "eth2_blockDataSize" (func $main/eth2_blockDataSize (result i32)))
 (import "env" "eth2_blockDataCopy" (func $main/eth2_blockDataCopy (param i32 i32 i32)))
 (import "env" "eth2_savePostStateRoot" (func $main/eth2_savePostStateRoot (param i32)))
 (import "watimports" "$bn128_g1m_timesScalar" (func $websnark_bn128/bn128_g1m_timesScalar (param i32 i32 i32 i32)))
 (import "watimports" "$bn128_g1m_add" (func $websnark_bn128/bn128_g1m_add (param i32 i32 i32)))
 (import "watimports" "$bn128_g1m_affine" (func $websnark_bn128/bn128_g1m_affine (param i32 i32)))
 (import "watimports" "$bn128_pairingEq4" (func $websnark_bn128/bn128_pairingEq4 (param i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))
 (memory $0 8)
 (global $~lib/rt/stub/startOffset (mut i32) (i32.const 0))
 (global $~lib/rt/stub/offset (mut i32) (i32.const 0))
 (export "memory" (memory $0))
 (export "debug_mem" (func $main/debug_mem))
 (export "eth2_blockDataSize" (func $main/eth2_blockDataSize))
 (export "eth2_blockDataCopy" (func $main/eth2_blockDataCopy))
 (export "eth2_savePostStateRoot" (func $main/eth2_savePostStateRoot))
 (export "main" (func $main/main))
 (start $start)
 (func $~lib/rt/stub/maybeGrowMemory (; 13 ;) (type $FUNCSIG$vi) (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  memory.size
  local.tee $2
  i32.const 16
  i32.shl
  local.tee $1
  i32.gt_u
  if
   local.get $2
   local.get $0
   local.get $1
   i32.sub
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $1
   local.get $2
   local.get $1
   i32.gt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $1
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
  end
  local.get $0
  global.set $~lib/rt/stub/offset
 )
 (func $~lib/rt/stub/__alloc (; 14 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 1073741808
  i32.gt_u
  if
   unreachable
  end
  global.get $~lib/rt/stub/offset
  i32.const 16
  i32.add
  local.tee $3
  local.get $0
  i32.const 15
  i32.add
  i32.const -16
  i32.and
  local.tee $2
  i32.const 16
  local.get $2
  i32.const 16
  i32.gt_u
  select
  local.tee $4
  i32.add
  call $~lib/rt/stub/maybeGrowMemory
  local.get $3
  i32.const 16
  i32.sub
  local.tee $2
  local.get $4
  i32.store
  local.get $2
  i32.const -1
  i32.store offset=4
  local.get $2
  local.get $1
  i32.store offset=8
  local.get $2
  local.get $0
  i32.store offset=12
  local.get $3
 )
 (func $~lib/memory/memory.fill (; 15 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  (local $2 i32)
  block $~lib/util/memory/memset|inlined.0
   local.get $1
   i32.eqz
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 0
   i32.store8
   local.get $0
   local.get $1
   i32.add
   i32.const 1
   i32.sub
   i32.const 0
   i32.store8
   local.get $1
   i32.const 2
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 1
   i32.add
   i32.const 0
   i32.store8
   local.get $0
   i32.const 2
   i32.add
   i32.const 0
   i32.store8
   local.get $0
   local.get $1
   i32.add
   local.tee $2
   i32.const 2
   i32.sub
   i32.const 0
   i32.store8
   local.get $2
   i32.const 3
   i32.sub
   i32.const 0
   i32.store8
   local.get $1
   i32.const 6
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 3
   i32.add
   i32.const 0
   i32.store8
   local.get $0
   local.get $1
   i32.add
   i32.const 4
   i32.sub
   i32.const 0
   i32.store8
   local.get $1
   i32.const 8
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $1
   i32.const 0
   local.get $0
   i32.sub
   i32.const 3
   i32.and
   local.tee $1
   i32.sub
   local.get $0
   local.get $1
   i32.add
   local.tee $0
   i32.const 0
   i32.store
   i32.const -4
   i32.and
   local.tee $1
   local.get $0
   i32.add
   i32.const 4
   i32.sub
   i32.const 0
   i32.store
   local.get $1
   i32.const 8
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 4
   i32.add
   i32.const 0
   i32.store
   local.get $0
   i32.const 8
   i32.add
   i32.const 0
   i32.store
   local.get $0
   local.get $1
   i32.add
   local.tee $2
   i32.const 12
   i32.sub
   i32.const 0
   i32.store
   local.get $2
   i32.const 8
   i32.sub
   i32.const 0
   i32.store
   local.get $1
   i32.const 24
   i32.le_u
   br_if $~lib/util/memory/memset|inlined.0
   local.get $0
   i32.const 12
   i32.add
   i32.const 0
   i32.store
   local.get $0
   i32.const 16
   i32.add
   i32.const 0
   i32.store
   local.get $0
   i32.const 20
   i32.add
   i32.const 0
   i32.store
   local.get $0
   i32.const 24
   i32.add
   i32.const 0
   i32.store
   local.get $0
   local.get $1
   i32.add
   local.tee $2
   i32.const 28
   i32.sub
   i32.const 0
   i32.store
   local.get $2
   i32.const 24
   i32.sub
   i32.const 0
   i32.store
   local.get $2
   i32.const 20
   i32.sub
   i32.const 0
   i32.store
   local.get $2
   i32.const 16
   i32.sub
   i32.const 0
   i32.store
   local.get $0
   i32.const 4
   i32.and
   i32.const 24
   i32.add
   local.tee $2
   local.get $0
   i32.add
   local.set $0
   local.get $1
   local.get $2
   i32.sub
   local.set $1
   loop $continue|0
    local.get $1
    i32.const 32
    i32.ge_u
    if
     local.get $0
     i64.const 0
     i64.store
     local.get $0
     i32.const 8
     i32.add
     i64.const 0
     i64.store
     local.get $0
     i32.const 16
     i32.add
     i64.const 0
     i64.store
     local.get $0
     i32.const 24
     i32.add
     i64.const 0
     i64.store
     local.get $1
     i32.const 32
     i32.sub
     local.set $1
     local.get $0
     i32.const 32
     i32.add
     local.set $0
     br $continue|0
    end
   end
  end
 )
 (func $~lib/arraybuffer/ArrayBuffer#constructor (; 16 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 1073741808
  i32.gt_u
  if
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/rt/stub/__alloc
  local.tee $1
  local.get $0
  call $~lib/memory/memory.fill
  local.get $1
 )
 (func $~lib/arraybuffer/ArrayBuffer#get:byteLength (; 17 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  local.get $0
  i32.const 16
  i32.sub
  i32.load offset=12
 )
 (func $~lib/typedarray/Uint8Array.wrap (; 18 ;) (type $FUNCSIG$iii) (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  block $folding-inner0
   local.get $1
   local.get $0
   call $~lib/arraybuffer/ArrayBuffer#get:byteLength
   i32.ge_u
   br_if $folding-inner0
   local.get $1
   i32.const 8
   i32.add
   local.get $0
   call $~lib/arraybuffer/ArrayBuffer#get:byteLength
   i32.gt_s
   br_if $folding-inner0
   i32.const 12
   i32.const 3
   call $~lib/rt/stub/__alloc
   local.tee $2
   local.get $0
   i32.store
   local.get $2
   i32.const 8
   i32.store offset=8
   local.get $2
   local.get $0
   local.get $1
   i32.add
   i32.store offset=4
   local.get $2
   return
  end
  unreachable
 )
 (func $~lib/typedarray/Uint8Array#__get (; 19 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  i32.const 0
  local.get $0
  i32.load offset=8
  i32.ge_u
  if
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.load8_u
 )
 (func $~lib/arraybuffer/ArrayBufferView#constructor (; 20 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 8
  i32.const 0
  call $~lib/rt/stub/__alloc
  local.tee $1
  i32.const 8
  call $~lib/memory/memory.fill
  local.get $0
  i32.eqz
  if
   i32.const 12
   i32.const 2
   call $~lib/rt/stub/__alloc
   local.set $0
  end
  local.get $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 0
  i32.store offset=4
  local.get $0
  i32.const 0
  i32.store offset=8
  local.get $0
  i32.load
  drop
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  i32.const 8
  i32.store offset=8
  local.get $0
 )
 (func $~lib/memory/memory.copy (; 21 ;) (type $FUNCSIG$viii) (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  block $~lib/util/memory/memmove|inlined.0
   local.get $2
   local.set $3
   local.get $0
   local.get $1
   i32.eq
   br_if $~lib/util/memory/memmove|inlined.0
   local.get $0
   local.get $1
   i32.lt_u
   if
    local.get $1
    i32.const 7
    i32.and
    local.get $0
    i32.const 7
    i32.and
    i32.eq
    if
     loop $continue|0
      local.get $0
      i32.const 7
      i32.and
      if
       local.get $3
       i32.eqz
       br_if $~lib/util/memory/memmove|inlined.0
       local.get $3
       i32.const 1
       i32.sub
       local.set $3
       local.get $0
       local.tee $2
       i32.const 1
       i32.add
       local.set $0
       local.get $1
       local.tee $4
       i32.const 1
       i32.add
       local.set $1
       local.get $2
       local.get $4
       i32.load8_u
       i32.store8
       br $continue|0
      end
     end
     loop $continue|1
      local.get $3
      i32.const 8
      i32.lt_u
      i32.eqz
      if
       local.get $0
       local.get $1
       i64.load
       i64.store
       local.get $3
       i32.const 8
       i32.sub
       local.set $3
       local.get $0
       i32.const 8
       i32.add
       local.set $0
       local.get $1
       i32.const 8
       i32.add
       local.set $1
       br $continue|1
      end
     end
    end
    loop $continue|2
     local.get $3
     if
      local.get $0
      local.tee $2
      i32.const 1
      i32.add
      local.set $0
      local.get $1
      local.tee $4
      i32.const 1
      i32.add
      local.set $1
      local.get $2
      local.get $4
      i32.load8_u
      i32.store8
      local.get $3
      i32.const 1
      i32.sub
      local.set $3
      br $continue|2
     end
    end
   else
    local.get $1
    i32.const 7
    i32.and
    local.get $0
    i32.const 7
    i32.and
    i32.eq
    if
     loop $continue|3
      local.get $0
      local.get $3
      i32.add
      i32.const 7
      i32.and
      if
       local.get $3
       i32.eqz
       br_if $~lib/util/memory/memmove|inlined.0
       local.get $0
       local.get $3
       i32.const 1
       i32.sub
       local.tee $3
       i32.add
       local.get $1
       local.get $3
       i32.add
       i32.load8_u
       i32.store8
       br $continue|3
      end
     end
     loop $continue|4
      local.get $3
      i32.const 8
      i32.lt_u
      i32.eqz
      if
       local.get $0
       local.get $3
       i32.const 8
       i32.sub
       local.tee $3
       i32.add
       local.get $1
       local.get $3
       i32.add
       i64.load
       i64.store
       br $continue|4
      end
     end
    end
    loop $continue|5
     local.get $3
     if
      local.get $0
      local.get $3
      i32.const 1
      i32.sub
      local.tee $3
      i32.add
      local.get $1
      local.get $3
      i32.add
      i32.load8_u
      i32.store8
      br $continue|5
     end
    end
   end
  end
 )
 (func $~lib/rt/stub/__realloc (; 22 ;) (type $FUNCSIG$ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.const 15
  i32.and
  i32.eqz
  i32.const 0
  local.get $0
  select
  i32.eqz
  if
   unreachable
  end
  local.get $0
  i32.const 16
  i32.sub
  local.tee $1
  i32.load
  local.set $2
  local.get $1
  i32.load offset=4
  i32.const -1
  i32.ne
  if
   unreachable
  end
  global.get $~lib/rt/stub/offset
  local.get $0
  local.get $2
  i32.add
  i32.eq
  local.set $3
  i32.const 4
  local.get $2
  i32.gt_u
  if
   local.get $3
   if
    local.get $0
    i32.const 16
    i32.add
    call $~lib/rt/stub/maybeGrowMemory
    local.get $1
    i32.const 16
    i32.store
   else
    i32.const 16
    local.get $2
    i32.const 1
    i32.shl
    local.tee $2
    i32.const 16
    local.get $2
    i32.gt_u
    select
    local.get $1
    i32.load offset=8
    call $~lib/rt/stub/__alloc
    local.tee $2
    local.get $0
    local.get $1
    i32.load offset=12
    call $~lib/memory/memory.copy
    local.get $2
    local.tee $0
    i32.const 16
    i32.sub
    local.set $1
   end
  else
   local.get $3
   if
    local.get $0
    i32.const 16
    i32.add
    global.set $~lib/rt/stub/offset
    local.get $1
    i32.const 16
    i32.store
   end
  end
  local.get $1
  i32.const 4
  i32.store offset=12
  local.get $0
 )
 (func $~lib/array/ensureSize (; 23 ;) (type $FUNCSIG$vi) (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 1
  local.get $0
  i32.load offset=8
  local.tee $2
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   local.get $2
   local.get $0
   i32.load
   local.tee $3
   call $~lib/rt/stub/__realloc
   local.tee $1
   i32.add
   i32.const 4
   local.get $2
   i32.sub
   call $~lib/memory/memory.fill
   local.get $1
   local.get $3
   i32.ne
   if
    local.get $0
    local.get $1
    i32.store
    local.get $0
    local.get $1
    i32.store offset=4
   end
   local.get $0
   i32.const 4
   i32.store offset=8
  end
 )
 (func $~lib/array/Array<u32>#__set (; 24 ;) (type $FUNCSIG$vii) (param $0 i32) (param $1 i32)
  local.get $0
  call $~lib/array/ensureSize
  local.get $0
  i32.load offset=4
  local.get $1
  i32.store
  i32.const 0
  local.get $0
  i32.load offset=12
  i32.ge_s
  if
   local.get $0
   i32.const 1
   i32.store offset=12
  end
 )
 (func $main/main (; 25 ;) (type $FUNCSIG$i) (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  i32.const 384
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $10
  call $websnark_bn128/bn128_ftm_one
  call $main/eth2_blockDataSize
  local.tee $1
  call $~lib/arraybuffer/ArrayBuffer#constructor
  local.tee $0
  i32.const 0
  local.get $1
  call $main/eth2_blockDataCopy
  local.get $0
  local.get $0
  call $websnark_bn128/bn128_g1m_toMontgomery
  local.get $0
  i32.const 96
  i32.add
  local.tee $5
  local.get $5
  call $websnark_bn128/bn128_g2m_toMontgomery
  local.get $0
  i32.const 480
  i32.add
  local.tee $6
  local.get $6
  call $websnark_bn128/bn128_g2m_toMontgomery
  local.get $0
  i32.const 288
  i32.add
  local.tee $7
  local.get $7
  call $websnark_bn128/bn128_g2m_toMontgomery
  local.get $0
  i32.const 672
  i32.add
  local.tee $8
  local.get $8
  call $websnark_bn128/bn128_g1m_toMontgomery
  local.get $0
  i32.const 768
  i32.add
  local.tee $9
  local.get $9
  call $websnark_bn128/bn128_g2m_toMontgomery
  local.get $0
  i32.const 960
  i32.add
  local.tee $3
  local.get $3
  call $websnark_bn128/bn128_g1m_toMontgomery
  local.get $0
  local.get $0
  i32.const 1056
  call $~lib/typedarray/Uint8Array.wrap
  call $~lib/typedarray/Uint8Array#__get
  i32.const 5
  i32.shl
  i32.const 3
  i32.mul
  local.tee $1
  i32.const 1064
  i32.add
  call $~lib/typedarray/Uint8Array.wrap
  call $~lib/typedarray/Uint8Array#__get
  local.set $11
  local.get $1
  local.get $0
  i32.const 1064
  i32.add
  local.tee $2
  i32.add
  i32.const 8
  i32.add
  local.set $12
  local.get $2
  local.get $2
  call $websnark_bn128/bn128_g1m_toMontgomery
  i32.const 0
  local.set $1
  loop $loop|0
   local.get $1
   local.get $11
   i32.lt_u
   if
    local.get $1
    i32.const 1
    i32.add
    local.tee $13
    i32.const 5
    i32.shl
    i32.const 3
    i32.mul
    local.get $2
    i32.add
    local.tee $4
    local.get $4
    call $websnark_bn128/bn128_g1m_toMontgomery
    local.get $4
    local.get $1
    i32.const 5
    i32.shl
    local.get $12
    i32.add
    i32.const 32
    local.get $4
    call $websnark_bn128/bn128_g1m_timesScalar
    local.get $4
    local.get $2
    local.get $2
    call $websnark_bn128/bn128_g1m_add
    local.get $13
    local.set $1
    br $loop|0
   end
  end
  local.get $2
  local.get $2
  call $websnark_bn128/bn128_g1m_affine
  local.get $2
  local.get $2
  call $websnark_bn128/bn128_g1m_neg
  local.get $3
  local.get $3
  call $websnark_bn128/bn128_g1m_neg
  local.get $0
  local.get $0
  call $websnark_bn128/bn128_g1m_neg
  i32.const 16
  i32.const 4
  call $~lib/rt/stub/__alloc
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.tee $1
  i32.const 0
  i32.store offset=12
  local.get $1
  i32.const 2
  i32.store offset=12
  local.get $8
  local.get $9
  local.get $2
  local.get $7
  local.get $3
  local.get $6
  local.get $0
  local.get $5
  local.get $10
  call $websnark_bn128/bn128_pairingEq4
  if
   local.get $1
   i32.const 0
   call $~lib/array/Array<u32>#__set
  else
   local.get $1
   i32.const 1
   call $~lib/array/Array<u32>#__set
  end
  local.get $1
  i32.load
  call $main/eth2_savePostStateRoot
  i32.const 0
 )
 (func $start (; 26 ;) (type $FUNCSIG$v)
  i32.const 512000
  global.set $~lib/rt/stub/startOffset
  i32.const 512000
  global.set $~lib/rt/stub/offset
 )
 (func $null (; 27 ;) (type $FUNCSIG$v)
  nop
 )
)