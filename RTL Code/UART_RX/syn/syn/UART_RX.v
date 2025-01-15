/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Tue Dec 13 02:41:10 2022
/////////////////////////////////////////////////////////////


module FSM ( RX_IN, PAR_EN, par_err, strt_glitch, stp_err, bit_cnt, edge_cnt, 
        Clk, RST, enable, par_chk_en, strt_chk_en, stp_chk_en, dat_samp_en, 
        deser_en, reset_cnt, data_valid );
  input [3:0] bit_cnt;
  input [3:0] edge_cnt;
  input RX_IN, PAR_EN, par_err, strt_glitch, stp_err, Clk, RST;
  output enable, par_chk_en, strt_chk_en, stp_chk_en, dat_samp_en, deser_en,
         reset_cnt, data_valid;
  wire   n31, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n2, n3, n4, n5, n6, n8, n9, n10, n30;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  NOR3X12M U26 ( .A(current_state[1]), .B(current_state[2]), .C(n9), .Y(
        strt_chk_en) );
  NOR3X12M U30 ( .A(current_state[0]), .B(current_state[2]), .C(n10), .Y(
        deser_en) );
  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(Clk), .RN(RST), .Q(
        current_state[1]) );
  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(Clk), .RN(RST), .Q(
        current_state[0]) );
  DFFRQX4M \current_state_reg[2]  ( .D(n2), .CK(Clk), .RN(RST), .Q(
        current_state[2]) );
  AOI33X2M U3 ( .A0(n30), .A1(n6), .A2(bit_cnt[0]), .B0(PAR_EN), .B1(n5), .B2(
        bit_cnt[1]), .Y(n27) );
  NOR3BX4M U4 ( .AN(n24), .B(bit_cnt[3]), .C(bit_cnt[0]), .Y(n19) );
  NOR3X8M U5 ( .A(n9), .B(current_state[2]), .C(n10), .Y(par_chk_en) );
  NOR3X2M U6 ( .A(bit_cnt[1]), .B(edge_cnt[3]), .C(bit_cnt[2]), .Y(n28) );
  CLKBUFX32M U7 ( .A(n31), .Y(data_valid) );
  AOI211X2M U8 ( .A0(par_err), .A1(PAR_EN), .B0(n11), .C0(stp_err), .Y(n31) );
  NAND2X2M U9 ( .A(n21), .B(n29), .Y(enable) );
  OAI21X4M U10 ( .A0(RX_IN), .A1(n11), .B0(n12), .Y(reset_cnt) );
  OAI211X2M U11 ( .A0(RX_IN), .A1(n21), .B0(n22), .C0(n23), .Y(next_state[0])
         );
  AOI22X1M U12 ( .A0(par_chk_en), .A1(n15), .B0(strt_chk_en), .B1(n4), .Y(n23)
         );
  AOI32X1M U13 ( .A0(n3), .A1(deser_en), .A2(PAR_EN), .B0(n25), .B1(n26), .Y(
        n22) );
  INVX2M U14 ( .A(n19), .Y(n4) );
  OAI21X2M U15 ( .A0(RX_IN), .A1(n12), .B0(n29), .Y(dat_samp_en) );
  INVX2M U16 ( .A(PAR_EN), .Y(n30) );
  NOR4X4M U17 ( .A(deser_en), .B(par_chk_en), .C(stp_chk_en), .D(strt_chk_en), 
        .Y(n29) );
  INVX2M U18 ( .A(n16), .Y(stp_chk_en) );
  AND2X2M U19 ( .A(n12), .B(n11), .Y(n21) );
  INVX2M U20 ( .A(par_chk_en), .Y(n8) );
  INVX2M U21 ( .A(n20), .Y(n3) );
  INVX4M U22 ( .A(current_state[1]), .Y(n10) );
  NAND3X2M U23 ( .A(current_state[0]), .B(n10), .C(current_state[2]), .Y(n11)
         );
  NOR4X2M U24 ( .A(edge_cnt[3]), .B(edge_cnt[0]), .C(bit_cnt[2]), .D(n27), .Y(
        n26) );
  INVX2M U25 ( .A(bit_cnt[1]), .Y(n6) );
  OAI2B11X2M U27 ( .A1N(n15), .A0(n8), .B0(n17), .C0(n18), .Y(next_state[1])
         );
  NAND3BX2M U28 ( .AN(strt_glitch), .B(strt_chk_en), .C(n19), .Y(n18) );
  OAI21X2M U29 ( .A0(PAR_EN), .A1(n20), .B0(deser_en), .Y(n17) );
  INVX2M U31 ( .A(n13), .Y(n2) );
  AOI31X2M U32 ( .A0(n3), .A1(n30), .A2(deser_en), .B0(n14), .Y(n13) );
  OAI31X2M U33 ( .A0(n8), .A1(par_err), .A2(n15), .B0(n16), .Y(n14) );
  INVX2M U34 ( .A(current_state[0]), .Y(n9) );
  NAND3X2M U35 ( .A(n9), .B(n10), .C(current_state[2]), .Y(n16) );
  OR3X2M U36 ( .A(current_state[2]), .B(current_state[1]), .C(current_state[0]), .Y(n12) );
  AND4X2M U37 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .C(edge_cnt[2]), .D(n28), 
        .Y(n24) );
  NAND3X2M U38 ( .A(bit_cnt[0]), .B(n24), .C(bit_cnt[3]), .Y(n15) );
  NAND3X2M U39 ( .A(n24), .B(n5), .C(bit_cnt[3]), .Y(n20) );
  INVX2M U40 ( .A(bit_cnt[0]), .Y(n5) );
  AND4X2M U41 ( .A(edge_cnt[1]), .B(edge_cnt[2]), .C(bit_cnt[3]), .D(
        stp_chk_en), .Y(n25) );
endmodule


module data_sampling ( RX_IN, dat_samp_en, Prescale, clk, rst, edge_cnt, 
        sampled_bit );
  input [4:0] Prescale;
  input [3:0] edge_cnt;
  input RX_IN, dat_samp_en, clk, rst;
  output sampled_bit;
  wire   samp1, samp2, samp3, N15, N16, N17, N18, N19, N20, N23, N24, N25, N26,
         N27, n11, n13, n14, n15, n16, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, \add_31/carry[3] , \add_31/carry[2] , n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n12, n17, n28, n29;

  DFFQX2M samp3_reg ( .D(n26), .CK(clk), .Q(samp3) );
  DFFQX2M samp1_reg ( .D(n27), .CK(clk), .Q(samp1) );
  EDFFHQX1M samp2_reg ( .D(RX_IN), .E(n25), .CK(clk), .Q(samp2) );
  DFFRQX4M sampled_bit_reg ( .D(n24), .CK(clk), .RN(rst), .Q(sampled_bit) );
  NOR4X2M U3 ( .A(n17), .B(n12), .C(N26), .D(n10), .Y(N27) );
  NOR3X2M U4 ( .A(n14), .B(N20), .C(n15), .Y(n25) );
  NOR4X4M U5 ( .A(n7), .B(n6), .C(N19), .D(n5), .Y(N20) );
  NOR2X2M U6 ( .A(n2), .B(Prescale[4]), .Y(N19) );
  OR2X2M U7 ( .A(n1), .B(Prescale[3]), .Y(n2) );
  OAI2BB1XLM U8 ( .A0N(n1), .A1N(Prescale[3]), .B0(n2), .Y(N17) );
  OR2X2M U9 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n1) );
  ADDHX1M U10 ( .A(Prescale[4]), .B(\add_31/carry[3] ), .CO(N26), .S(N25) );
  ADDHX1M U11 ( .A(Prescale[2]), .B(Prescale[1]), .CO(\add_31/carry[2] ), .S(
        N23) );
  ADDHX1M U12 ( .A(Prescale[3]), .B(\add_31/carry[2] ), .CO(\add_31/carry[3] ), 
        .S(N24) );
  INVX2M U13 ( .A(n15), .Y(n18) );
  INVX2M U14 ( .A(RX_IN), .Y(n29) );
  OAI2BB2X1M U15 ( .B0(n29), .B1(n23), .A0N(n23), .A1N(samp1), .Y(n27) );
  NAND2X1M U16 ( .A(N20), .B(n18), .Y(n23) );
  OAI2BB2X1M U17 ( .B0(n16), .B1(n29), .A0N(n16), .A1N(samp3), .Y(n26) );
  NAND4BX2M U18 ( .AN(N20), .B(N27), .C(n18), .D(n14), .Y(n16) );
  XNOR2X2M U19 ( .A(edge_cnt[0]), .B(Prescale[1]), .Y(n21) );
  NAND4X2M U20 ( .A(n19), .B(n20), .C(n21), .D(n22), .Y(n14) );
  XNOR2X2M U21 ( .A(edge_cnt[2]), .B(Prescale[3]), .Y(n19) );
  XNOR2X2M U22 ( .A(edge_cnt[3]), .B(Prescale[4]), .Y(n20) );
  XNOR2X2M U23 ( .A(edge_cnt[1]), .B(Prescale[2]), .Y(n22) );
  NAND2X2M U24 ( .A(rst), .B(dat_samp_en), .Y(n15) );
  OAI2BB2X1M U25 ( .B0(n11), .B1(n28), .A0N(sampled_bit), .A1N(n28), .Y(n24)
         );
  AOI21X2M U26 ( .A0(samp2), .A1(samp1), .B0(n13), .Y(n11) );
  INVX2M U27 ( .A(dat_samp_en), .Y(n28) );
  OA21X2M U28 ( .A0(samp2), .A1(samp1), .B0(samp3), .Y(n13) );
  CLKINVX1M U29 ( .A(Prescale[1]), .Y(N15) );
  OAI2BB1X1M U30 ( .A0N(Prescale[1]), .A1N(Prescale[2]), .B0(n1), .Y(N16) );
  AO21XLM U31 ( .A0(n2), .A1(Prescale[4]), .B0(N19), .Y(N18) );
  XNOR2X1M U32 ( .A(N17), .B(edge_cnt[2]), .Y(n4) );
  XNOR2X1M U33 ( .A(N18), .B(edge_cnt[3]), .Y(n3) );
  CLKNAND2X2M U34 ( .A(n4), .B(n3), .Y(n7) );
  CLKXOR2X2M U35 ( .A(N16), .B(edge_cnt[1]), .Y(n6) );
  CLKXOR2X2M U36 ( .A(N15), .B(edge_cnt[0]), .Y(n5) );
  XNOR2X1M U37 ( .A(N24), .B(edge_cnt[2]), .Y(n9) );
  XNOR2X1M U38 ( .A(N25), .B(edge_cnt[3]), .Y(n8) );
  CLKNAND2X2M U39 ( .A(n9), .B(n8), .Y(n17) );
  CLKXOR2X2M U40 ( .A(N23), .B(edge_cnt[1]), .Y(n12) );
  CLKXOR2X2M U41 ( .A(N15), .B(edge_cnt[0]), .Y(n10) );
endmodule


module edge_bit_counter ( enable, reset_cnt, Prescale, clk, rst, bit_cnt, 
        edge_cnt );
  input [4:0] Prescale;
  output [3:0] bit_cnt;
  output [3:0] edge_cnt;
  input enable, reset_cnt, clk, rst;
  wire   N7, n3, n6, n8, n9, n10, n11, n14, n15, n16, n19, n21, n22, n23, n24,
         n25, n26, n30, n31, n32, n33, n34, n36, n37, n38, n39, n1, n2, n4, n5,
         n7, n12, n13, n17, n18, n20, n27, n28, n29, n35, n40, n41, n42;

  DFFRX4M \edge_cnt_reg[0]  ( .D(n34), .CK(clk), .RN(rst), .Q(edge_cnt[0]), 
        .QN(n18) );
  DFFRX4M \edge_cnt_reg[3]  ( .D(n31), .CK(clk), .RN(rst), .Q(edge_cnt[3]), 
        .QN(n28) );
  DFFRX4M \edge_cnt_reg[2]  ( .D(n32), .CK(clk), .RN(rst), .Q(edge_cnt[2]), 
        .QN(n27) );
  DFFRX4M \edge_cnt_reg[1]  ( .D(n33), .CK(clk), .RN(rst), .Q(edge_cnt[1]), 
        .QN(n20) );
  DFFRX4M \bit_cnt_reg[1]  ( .D(n38), .CK(clk), .RN(rst), .Q(bit_cnt[1]), .QN(
        n35) );
  DFFRQX4M \bit_cnt_reg[0]  ( .D(n39), .CK(clk), .RN(rst), .Q(bit_cnt[0]) );
  DFFRQX4M \bit_cnt_reg[2]  ( .D(n12), .CK(clk), .RN(rst), .Q(bit_cnt[2]) );
  DFFRX2M \bit_cnt_reg[3]  ( .D(n37), .CK(clk), .RN(rst), .Q(bit_cnt[3]), .QN(
        n36) );
  NAND4X1M U3 ( .A(n36), .B(bit_cnt[2]), .C(bit_cnt[1]), .D(n21), .Y(n24) );
  NOR4X4M U4 ( .A(n7), .B(n5), .C(Prescale[4]), .D(n4), .Y(N7) );
  AOI21X2M U5 ( .A0(n42), .A1(n25), .B0(n41), .Y(n30) );
  INVX2M U6 ( .A(n30), .Y(n17) );
  INVX4M U7 ( .A(enable), .Y(n41) );
  AOI2B1X2M U8 ( .A1N(n10), .A0(n8), .B0(n41), .Y(n9) );
  INVX2M U9 ( .A(n25), .Y(n13) );
  INVX2M U10 ( .A(reset_cnt), .Y(n42) );
  NAND2X3M U11 ( .A(N7), .B(n42), .Y(n25) );
  NOR3X6M U12 ( .A(n25), .B(n17), .C(n29), .Y(n21) );
  AOI21X2M U13 ( .A0(n29), .A1(n13), .B0(n17), .Y(n26) );
  NOR2X6M U14 ( .A(N7), .B(reset_cnt), .Y(n8) );
  OAI22X1M U15 ( .A0(enable), .A1(n18), .B0(n16), .B1(n41), .Y(n34) );
  AOI21X2M U16 ( .A0(n18), .A1(n42), .B0(n13), .Y(n16) );
  OAI21X2M U17 ( .A0(n9), .A1(n27), .B0(n11), .Y(n32) );
  NAND4X2M U18 ( .A(enable), .B(n8), .C(n10), .D(n27), .Y(n11) );
  NOR2X4M U19 ( .A(n20), .B(n18), .Y(n10) );
  OAI32X2M U20 ( .A0(n25), .A1(bit_cnt[0]), .A2(n17), .B0(n30), .B1(n29), .Y(
        n39) );
  OAI21X2M U21 ( .A0(bit_cnt[1]), .A1(n25), .B0(n26), .Y(n22) );
  OAI2BB2X1M U22 ( .B0(n26), .B1(n35), .A0N(n35), .A1N(n21), .Y(n38) );
  OAI21X2M U23 ( .A0(n36), .A1(n23), .B0(n24), .Y(n37) );
  AOI21X2M U24 ( .A0(n13), .A1(n40), .B0(n22), .Y(n23) );
  INVX2M U25 ( .A(n19), .Y(n12) );
  AOI32X1M U26 ( .A0(bit_cnt[1]), .A1(n40), .A2(n21), .B0(n22), .B1(bit_cnt[2]), .Y(n19) );
  OAI32X2M U27 ( .A0(n3), .A1(n27), .A2(n41), .B0(n6), .B1(n28), .Y(n31) );
  NAND3X2M U28 ( .A(n10), .B(n28), .C(n8), .Y(n3) );
  AOI21BX2M U29 ( .A0(n8), .A1(n27), .B0N(n9), .Y(n6) );
  OAI21X2M U30 ( .A0(n14), .A1(n20), .B0(n15), .Y(n33) );
  NAND4X2M U31 ( .A(enable), .B(n8), .C(edge_cnt[0]), .D(n20), .Y(n15) );
  AOI21X2M U32 ( .A0(n8), .A1(n18), .B0(n41), .Y(n14) );
  INVX2M U33 ( .A(bit_cnt[0]), .Y(n29) );
  INVX2M U34 ( .A(bit_cnt[2]), .Y(n40) );
  XNOR2X1M U35 ( .A(Prescale[2]), .B(edge_cnt[2]), .Y(n2) );
  XNOR2X1M U36 ( .A(Prescale[3]), .B(edge_cnt[3]), .Y(n1) );
  CLKNAND2X2M U37 ( .A(n2), .B(n1), .Y(n7) );
  CLKXOR2X2M U38 ( .A(Prescale[1]), .B(edge_cnt[1]), .Y(n5) );
  CLKXOR2X2M U39 ( .A(Prescale[0]), .B(edge_cnt[0]), .Y(n4) );
endmodule


module deserializer ( deser_en, sampled_bit, clk, rst, edge_cnt, P_DATA );
  input [3:0] edge_cnt;
  output [7:0] P_DATA;
  input deser_en, sampled_bit, clk, rst;
  wire   n34, n35, n36, n37, n38, n39, n40, n41, n1, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n2, n4, n6, n8, n19, n21, n25, n26, n27, n28, n29,
         n30, n31, n32, n33;

  DFFRQX2M \P_DATA_reg[1]  ( .D(n12), .CK(clk), .RN(rst), .Q(n40) );
  DFFRQX2M \P_DATA_reg[0]  ( .D(n11), .CK(clk), .RN(rst), .Q(n41) );
  DFFRX1M \P_DATA_reg[7]  ( .D(n18), .CK(clk), .RN(rst), .Q(n34), .QN(n26) );
  DFFRX1M \P_DATA_reg[2]  ( .D(n13), .CK(clk), .RN(rst), .Q(n39), .QN(n31) );
  DFFRX1M \P_DATA_reg[5]  ( .D(n16), .CK(clk), .RN(rst), .Q(n36), .QN(n28) );
  DFFRX1M \P_DATA_reg[4]  ( .D(n15), .CK(clk), .RN(rst), .Q(n37), .QN(n29) );
  DFFRX1M \P_DATA_reg[3]  ( .D(n14), .CK(clk), .RN(rst), .Q(n38), .QN(n30) );
  DFFRX1M \P_DATA_reg[6]  ( .D(n17), .CK(clk), .RN(rst), .Q(n35), .QN(n27) );
  NAND4X2M U2 ( .A(edge_cnt[2]), .B(edge_cnt[1]), .C(n10), .D(deser_en), .Y(n1) );
  NOR2X2M U3 ( .A(edge_cnt[3]), .B(edge_cnt[0]), .Y(n10) );
  INVX2M U4 ( .A(n39), .Y(n2) );
  CLKINVX32M U5 ( .A(n2), .Y(P_DATA[2]) );
  INVX2M U6 ( .A(n36), .Y(n4) );
  CLKINVX32M U7 ( .A(n4), .Y(P_DATA[5]) );
  INVX2M U8 ( .A(n37), .Y(n6) );
  CLKINVX32M U9 ( .A(n6), .Y(P_DATA[4]) );
  INVX2M U10 ( .A(n38), .Y(n8) );
  CLKINVX32M U11 ( .A(n8), .Y(P_DATA[3]) );
  INVX2M U12 ( .A(n34), .Y(n19) );
  CLKINVX32M U13 ( .A(n19), .Y(P_DATA[7]) );
  INVX2M U14 ( .A(n35), .Y(n21) );
  CLKINVX32M U15 ( .A(n21), .Y(P_DATA[6]) );
  CLKBUFX40M U16 ( .A(n41), .Y(P_DATA[0]) );
  CLKINVX32M U17 ( .A(n32), .Y(P_DATA[1]) );
  INVX2M U18 ( .A(n40), .Y(n32) );
  INVX4M U19 ( .A(n25), .Y(n33) );
  OAI22X1M U20 ( .A0(n25), .A1(n30), .B0(n33), .B1(n31), .Y(n13) );
  OAI22X1M U21 ( .A0(n25), .A1(n26), .B0(n33), .B1(n27), .Y(n17) );
  OAI22X1M U22 ( .A0(n25), .A1(n31), .B0(n33), .B1(n32), .Y(n12) );
  OAI22X1M U23 ( .A0(n25), .A1(n29), .B0(n33), .B1(n30), .Y(n14) );
  OAI22X1M U24 ( .A0(n25), .A1(n28), .B0(n33), .B1(n29), .Y(n15) );
  OAI22X1M U25 ( .A0(n25), .A1(n27), .B0(n33), .B1(n28), .Y(n16) );
  OAI2BB2X1M U26 ( .B0(n33), .B1(n26), .A0N(sampled_bit), .A1N(n33), .Y(n18)
         );
  OAI2BB2X1M U27 ( .B0(n25), .B1(n32), .A0N(P_DATA[0]), .A1N(n25), .Y(n11) );
  CLKBUFX6M U28 ( .A(n1), .Y(n25) );
endmodule


module parity_check ( par_chk_en, sampled_bit, PAR_TYP, P_DATA, clk, rst, 
        par_err );
  input [7:0] P_DATA;
  input par_chk_en, sampled_bit, PAR_TYP, clk, rst;
  output par_err;
  wire   n1, n3, n4, n5, n6, n8, n2, n7;

  DFFRQX2M par_err_reg ( .D(n8), .CK(clk), .RN(rst), .Q(par_err) );
  XNOR2X2M U2 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  XNOR3XLM U3 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n2), .Y(n3) );
  XNOR2X2M U4 ( .A(sampled_bit), .B(PAR_TYP), .Y(n5) );
  OAI2BB2X1M U5 ( .B0(n1), .B1(n7), .A0N(par_err), .A1N(n7), .Y(n8) );
  INVX2M U6 ( .A(par_chk_en), .Y(n7) );
  XOR3XLM U7 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  XOR3XLM U8 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n4) );
  CLKXOR2X2M U9 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n2) );
endmodule


module strt_check ( strt_chk_en, sampled_bit, clk, rst, strt_glitch );
  input strt_chk_en, sampled_bit, clk, rst;
  output strt_glitch;
  wire   n1;

  DFFRQX2M strt_glitch_reg ( .D(n1), .CK(clk), .RN(rst), .Q(strt_glitch) );
  AO2B2X2M U2 ( .B0(strt_chk_en), .B1(sampled_bit), .A0(strt_glitch), .A1N(
        strt_chk_en), .Y(n1) );
endmodule


module Stop_check ( stp_chk_en, sampled_bit, clk, rst, stp_err );
  input stp_chk_en, sampled_bit, clk, rst;
  output stp_err;
  wire   n2, n1;

  DFFRQX2M stp_err_reg ( .D(n2), .CK(clk), .RN(rst), .Q(stp_err) );
  OAI2BB2X1M U2 ( .B0(sampled_bit), .B1(n1), .A0N(stp_err), .A1N(n1), .Y(n2)
         );
  INVX2M U3 ( .A(stp_chk_en), .Y(n1) );
endmodule


module UART_RX ( RX_IN, Prescale, PAR_EN, PAR_TYP, CLK, RST, data_valid, 
        P_DATA );
  input [4:0] Prescale;
  output [7:0] P_DATA;
  input RX_IN, PAR_EN, PAR_TYP, CLK, RST;
  output data_valid;
  wire   par_err, strt_glitch, stp_err, enable, par_chk_en, strt_chk_en,
         stp_chk_en, dat_samp_en, deser_en, reset_cnt, sampled_bit, n1, n2, n3,
         n4, n5, n6;
  wire   [3:0] bit_cnt;
  wire   [3:0] edge_cnt;

  FSM U_FSM ( .RX_IN(n6), .PAR_EN(n1), .par_err(par_err), .strt_glitch(
        strt_glitch), .stp_err(stp_err), .bit_cnt(bit_cnt), .edge_cnt(edge_cnt), .Clk(CLK), .RST(RST), .enable(enable), .par_chk_en(par_chk_en), 
        .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), .dat_samp_en(
        dat_samp_en), .deser_en(deser_en), .reset_cnt(reset_cnt), .data_valid(
        data_valid) );
  data_sampling U_data_sampling ( .RX_IN(n6), .dat_samp_en(dat_samp_en), 
        .Prescale({n5, n4, n3, n2, Prescale[0]}), .clk(CLK), .rst(RST), 
        .edge_cnt(edge_cnt), .sampled_bit(sampled_bit) );
  edge_bit_counter U_edge_bit_counter ( .enable(enable), .reset_cnt(reset_cnt), 
        .Prescale({n5, n4, n3, n2, Prescale[0]}), .clk(CLK), .rst(RST), 
        .bit_cnt(bit_cnt), .edge_cnt(edge_cnt) );
  deserializer U_deserializer ( .deser_en(deser_en), .sampled_bit(sampled_bit), 
        .clk(CLK), .rst(RST), .edge_cnt(edge_cnt), .P_DATA(P_DATA) );
  parity_check U_parity_check ( .par_chk_en(par_chk_en), .sampled_bit(
        sampled_bit), .PAR_TYP(PAR_TYP), .P_DATA(P_DATA), .clk(CLK), .rst(RST), 
        .par_err(par_err) );
  strt_check U_strt_check ( .strt_chk_en(strt_chk_en), .sampled_bit(
        sampled_bit), .clk(CLK), .rst(RST), .strt_glitch(strt_glitch) );
  Stop_check U_Stop_check ( .stp_chk_en(stp_chk_en), .sampled_bit(sampled_bit), 
        .clk(CLK), .rst(RST), .stp_err(stp_err) );
  BUFX4M U1 ( .A(PAR_EN), .Y(n1) );
  BUFX4M U2 ( .A(Prescale[1]), .Y(n2) );
  BUFX4M U3 ( .A(Prescale[2]), .Y(n3) );
  BUFX4M U4 ( .A(Prescale[3]), .Y(n4) );
  BUFX4M U5 ( .A(Prescale[4]), .Y(n5) );
  BUFX4M U6 ( .A(RX_IN), .Y(n6) );
endmodule

