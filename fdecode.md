# fdecode

假设传入的指令是`instruction`，位宽是32

## `fadd.s frd, frs1, frs2`

该指令是S型指令

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00000                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |





## `fsub.s frd, frs1, frs2`
| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00001                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



## `fmul.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00010                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



## `fmin.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00101                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode，值是000                                      |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



## `fmax.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00101                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode，值是001                                      |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |



## `fmadd.s frd, frs1, frs2, frs3`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1000011    |



## `fnmadd.s frd, frs1, frs2, frs3`
| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1001111    |


## `fmsub.s frd, frs1, frs2, frs3`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1000111    |

## `fnmsub.s frd, frs1, frs2, frs3`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `frs3`    | `instruction[31:27]` | 第三个操作数   |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 第二个操作数   |
| `frs1`    | `instruction[19:15]` | 第一个操作数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1001011    |



## `fcvt.w.s rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00000   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fcvt.wu.s rd, frs1`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00001   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fcvt.l.s rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00010   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fcvt.lu.s rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11000   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` | 值是00011   |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fcvt.s.w frd, rs1`



| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fcvt.s.wu frd, rs1`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00001   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


## `fcvt.s.l frd, rs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00010   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

## `fcvt.s.lu frd, rs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11010   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00011   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` |             |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fsgnj.s frd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是00100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fsgnjn.s frd, frs1, frs2`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是00100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是001     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


## `fsgnjx.s frd, frs1, frs2`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是00100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是010     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


## `feq.s rd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是10100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是010     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `flt.s rd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是10100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是001     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

## `fle.s rd, frs1, frs2`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是10100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `frs2`    | `instruction[24:20]` |             |
| `frs1`    | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

## `fclass rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是001     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |



## `fmv.w.x frd, rs1`
| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11110   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |


## `fmv.x.w rd, frs1`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `funct5`  | `instruction[31:27]` | 值是11100   |
| `fmt`     | `instruction[26:25]` | 值是00      |
| `rs2`     | `instruction[24:20]` | 值是00000   |
| `rs1`     | `instruction[19:15]` |             |
| `rm`      | `instruction[14:12]` | 值是000     |
| `frd`     | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是1010011 |

## `fdiv.s frd, frs1, frs2`

| Attribute | Value                | Description                                                 |
| --------- | -------------------- | ----------------------------------------------------------- |
| `funct5`  | `instruction[31:27]` | 值是00011                                                   |
| `fmt`     | `instruction[26:25]` | 值是00                                                      |
| `frs2`    | `instruction[24:20]` | 和整数指令集编码方式一样，假设是寄存器`f0`，那么这一位就是0 |
| `frs1`    | `instruction[19:15]` | 第一个运算数                                                |
| `rm`      | `instruction[14:12]` | rounding mode                                               |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器                                              |
| `opcode`  | `instruction[6:0]`   | 值是1010011                                                 |

## `fsqrt.s frd, frs1`

| Attribute | Value                | Description    |
| --------- | -------------------- | -------------- |
| `funct5`  | `instruction[31:27]` | 值是01011      |
| `fmt`     | `instruction[26:25]` | 值是00         |
| `frs2`    | `instruction[24:20]` | 值是00000      |
| `frs1`    | `instruction[19:15]` | 第一个运算数   |
| `rm`      | `instruction[14:12]` | rounding mode  |
| `frd`     | `instruction[11:7]`  | 要写回的寄存器 |
| `opcode`  | `instruction[6:0]`   | 值是1010011    |



## `flw frd, offset(rs)`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `offset`  | `instruction[31:20]` |             |
| `rs1`     | `instruction[19:15]` |             |
| `width`   | `instruction[14:12]` | 值是010     |
| `rd`      | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是0000111 |



## `fsw frs2, offset(rs1)`

| Attribute | Value                | Description |
| --------- | -------------------- | ----------- |
| `offset[11:5]` | `instruction[31:25]` |             |
|`frs2`|`instruction[24:20]`||
| `rs1`     | `instruction[19:15]` |             |
| `width`   | `instruction[14:12]` | 值是010     |
| `offset[4:0]` | `instruction[11:7]`  |             |
| `opcode`  | `instruction[6:0]`   | 值是0100111 |



## `rv_decoder`接口



## `rvc_decoder`接口



## `decoder`接口

