using QuantumClifford
using QuantumClifford.ECC
import QuantumClifford.ECC: parity_checks, code_k, code_n

struct TestCode end

parity_checks(c::TestCode) = S"""
+ XY__Z_ZZXY_XXYXYX_ZZ
- ZXYZY_X____YZZ_YXZZY
- Y_X__X_Y_Y_ZYYX__Z_Z
+ YZ__XY_X_____Y_XYZ__
+ XZYYYY_ZX_XYZ___YYZX
+ XXXXY__ZZZY_YYYZXZXZ
- X_ZXYXXZ_ZZXZYXZYYYX
+ XXYYYZZYZY_ZY__XZZYY
+ Y_YYXYZZ____XYZ__YY_
- X_ZYZXXY_XZ_XY__XXZX
+ XYY_YYZZ_Z__XZ___XY_
- X_ZXZ_YZZ_ZZZYY_Z_XX
- YYZ__X_Z_Z_YX_XY__ZY
- _YXZXZYZYYZ_ZYX__XZ_
+ _XXX_YYXXZZ_YY_ZZXYZ
- YXXZXZ_X_Z_XZZ_ZZXZX
- XZXXZ___XYXXYXXZZXY_
- Z_XYYYZY_XYZZXXXZYXZ
- XZX_X_Y_Z_ZXYX_Y_X_Z
"""

code_n(c::TestCode) = 20
code_k(c::TestCode) = 1

c = TestCode()

# check it is a valid code
for ps1 in parity_checks(c)
    for ps2 in parity_checks(c)
        @assert comm(ps1, ps2) == 0x0
    end
end

noise = 0.001

d = TableDecoder
s = ShorSyndromeECCSetup(noise, 0)

e = evaluate_decoder(d(c), s, 100000)
