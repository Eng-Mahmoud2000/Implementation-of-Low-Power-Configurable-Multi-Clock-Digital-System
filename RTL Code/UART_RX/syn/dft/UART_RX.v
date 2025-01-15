/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Tue Dec 13 05:46:44 2022
/////////////////////////////////////////////////////////////


module FSM_test_1 ( RX_IN, PAR_EN, par_err, strt_glitch, stp_err, bit_cnt, 
        edge_cnt, Clk, RST, enable, par_chk_en, strt_chk_en, stp_chk_en, 
        dat_samp_en, deser_en, reset_cnt, data_valid, test_si, test_so, 
        test_se );
  input [3:0] bit_cnt;
  input [3:0] edge_cnt;
  input RX_IN, PAR_EN, par_err, strt_glitch, stp_err, Clk, RST, test_si,
         test_se;
  output enable, par_chk_en, strt_chk_en, stp_chk_en, dat_samp_en, deser_en,
         reset_cnt, data_valid, test_so;
  wire   n41, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n4, n5, n6, n7, n8, n13, n33, n34, n35,
         n36, n38, n39, n40, n44, n1;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  CLKINVX2M U6 ( .A(n44), .Y(n7) );
  INVX2M U7 ( .A(current_state[0]), .Y(n6) );
  AND4X2M U8 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .C(edge_cnt[2]), .D(n31), .Y(
        n27) );
  NOR3X2M U9 ( .A(bit_cnt[1]), .B(edge_cnt[3]), .C(bit_cnt[2]), .Y(n31) );
  AOI211X2M U10 ( .A0(par_err), .A1(PAR_EN), .B0(n14), .C0(stp_err), .Y(n41)
         );
  NOR3BX4M U11 ( .AN(n27), .B(bit_cnt[3]), .C(bit_cnt[0]), .Y(n22) );
  NAND3BXLM U12 ( .AN(strt_glitch), .B(strt_chk_en), .C(n22), .Y(n21) );
  NOR4X4M U13 ( .A(deser_en), .B(par_chk_en), .C(stp_chk_en), .D(strt_chk_en), 
        .Y(n32) );
  NOR3X12M U14 ( .A(n6), .B(test_so), .C(n5), .Y(strt_chk_en) );
  NOR3X12M U15 ( .A(n7), .B(test_so), .C(n39), .Y(deser_en) );
  INVX2M U17 ( .A(n4), .Y(n5) );
  NOR3X8M U18 ( .A(n6), .B(test_so), .C(n39), .Y(par_chk_en) );
  CLKINVX1M U19 ( .A(n41), .Y(n8) );
  CLKINVX32M U20 ( .A(n8), .Y(data_valid) );
  NAND2X2M U24 ( .A(n24), .B(n32), .Y(enable) );
  OAI21X4M U25 ( .A0(RX_IN), .A1(n14), .B0(n15), .Y(reset_cnt) );
  OAI211X2M U26 ( .A0(RX_IN), .A1(n24), .B0(n25), .C0(n26), .Y(next_state[0])
         );
  AOI22X1M U27 ( .A0(par_chk_en), .A1(n18), .B0(strt_chk_en), .B1(n34), .Y(n26) );
  AOI32X1M U28 ( .A0(n33), .A1(deser_en), .A2(PAR_EN), .B0(n28), .B1(n29), .Y(
        n25) );
  INVX2M U29 ( .A(n22), .Y(n34) );
  OAI21X2M U30 ( .A0(RX_IN), .A1(n15), .B0(n32), .Y(dat_samp_en) );
  INVX2M U31 ( .A(PAR_EN), .Y(n40) );
  INVX2M U32 ( .A(n19), .Y(stp_chk_en) );
  AND2X2M U33 ( .A(n15), .B(n14), .Y(n24) );
  INVX2M U34 ( .A(par_chk_en), .Y(n38) );
  INVX2M U35 ( .A(n23), .Y(n33) );
  INVX4M U36 ( .A(n5), .Y(n39) );
  NAND3X2M U37 ( .A(n7), .B(n39), .C(test_so), .Y(n14) );
  NOR4X2M U38 ( .A(edge_cnt[3]), .B(edge_cnt[0]), .C(bit_cnt[2]), .D(n30), .Y(
        n29) );
  AOI33X2M U39 ( .A0(n40), .A1(n36), .A2(bit_cnt[0]), .B0(PAR_EN), .B1(n35), 
        .B2(bit_cnt[1]), .Y(n30) );
  INVX2M U40 ( .A(bit_cnt[1]), .Y(n36) );
  OAI2B11X2M U41 ( .A1N(n18), .A0(n38), .B0(n20), .C0(n21), .Y(next_state[1])
         );
  OAI21X2M U42 ( .A0(PAR_EN), .A1(n23), .B0(deser_en), .Y(n20) );
  INVX2M U43 ( .A(n16), .Y(n13) );
  AOI31X2M U44 ( .A0(n33), .A1(n40), .A2(deser_en), .B0(n17), .Y(n16) );
  OAI31X2M U45 ( .A0(n38), .A1(par_err), .A2(n18), .B0(n19), .Y(n17) );
  NAND3X2M U46 ( .A(n6), .B(n39), .C(test_so), .Y(n19) );
  OR3X2M U47 ( .A(test_so), .B(n5), .C(n7), .Y(n15) );
  NAND3X2M U48 ( .A(bit_cnt[0]), .B(n27), .C(bit_cnt[3]), .Y(n18) );
  INVX2M U49 ( .A(bit_cnt[0]), .Y(n35) );
  NAND3X2M U50 ( .A(n27), .B(n35), .C(bit_cnt[3]), .Y(n23) );
  AND4X2M U51 ( .A(edge_cnt[1]), .B(edge_cnt[2]), .C(bit_cnt[3]), .D(
        stp_chk_en), .Y(n28) );
  SDFFRX1M \current_state_reg[1]  ( .D(next_state[1]), .SI(n6), .SE(test_se), 
        .CK(Clk), .RN(RST), .QN(n4) );
  SDFFRX1M \current_state_reg[2]  ( .D(n13), .SI(n39), .SE(test_se), .CK(Clk), 
        .RN(RST), .Q(current_state[2]) );
  SDFFRX1M \current_state_reg[0]  ( .D(next_state[0]), .SI(test_si), .SE(
        test_se), .CK(Clk), .RN(RST), .Q(current_state[0]), .QN(n44) );
  INVXLM U3 ( .A(current_state[2]), .Y(n1) );
  INVX4M U4 ( .A(n1), .Y(test_so) );
endmodule


module data_sampling_test_1 ( RX_IN, dat_samp_en, Prescale, clk, rst, edge_cnt, 
        sampled_bit, test_si, test_se );
  input [4:0] Prescale;
  input [3:0] edge_cnt;
  input RX_IN, dat_samp_en, clk, rst, test_si, test_se;
  output sampled_bit;
  wire   samp1, samp2, samp3, N15, N16, N17, N18, N19, N20, N23, N24, N25, N26,
         N27, n11, n13, n14, n16, n17, n18, n19, n20, n21, n22, n23, n25, n29,
         n30, n31, \add_31/carry[3] , \add_31/carry[2] , n1, n7, n8, n9, n10,
         n12, n15, n32, n33, n34, n35, n36, n37, n38, n39, n43;

  SDFFQX1M samp3_reg ( .D(n29), .SI(samp2), .SE(test_se), .CK(clk), .Q(samp3)
         );
  SDFFQX2M samp2_reg ( .D(n31), .SI(samp1), .SE(test_se), .CK(clk), .Q(samp2)
         );
  SDFFQX2M samp1_reg ( .D(n30), .SI(test_si), .SE(test_se), .CK(clk), .Q(samp1) );
  NOR3BX1M U3 ( .AN(n16), .B(N20), .C(n17), .Y(n19) );
  NAND4BX1M U4 ( .AN(N20), .B(N27), .C(n16), .D(n17), .Y(n14) );
  NOR4X4M U5 ( .A(n32), .B(n15), .C(N19), .D(n12), .Y(N20) );
  INVX4M U7 ( .A(n1), .Y(sampled_bit) );
  NOR2X2M U12 ( .A(n8), .B(Prescale[4]), .Y(N19) );
  OR2X2M U13 ( .A(n7), .B(Prescale[3]), .Y(n8) );
  OAI2BB1XLM U14 ( .A0N(n7), .A1N(Prescale[3]), .B0(n8), .Y(N17) );
  OR2X2M U15 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n7) );
  ADDHX1M U16 ( .A(Prescale[4]), .B(\add_31/carry[3] ), .CO(N26), .S(N25) );
  ADDHX1M U17 ( .A(Prescale[2]), .B(Prescale[1]), .CO(\add_31/carry[2] ), .S(
        N23) );
  ADDHX1M U18 ( .A(Prescale[3]), .B(\add_31/carry[2] ), .CO(\add_31/carry[3] ), 
        .S(N24) );
  AND2X1M U19 ( .A(rst), .B(dat_samp_en), .Y(n16) );
  INVX2M U20 ( .A(RX_IN), .Y(n39) );
  OAI2BB2X1M U21 ( .B0(n39), .B1(n18), .A0N(n18), .A1N(samp1), .Y(n30) );
  NAND2X1M U22 ( .A(N20), .B(n16), .Y(n18) );
  AO2B2X2M U23 ( .B0(RX_IN), .B1(n19), .A0(samp2), .A1N(n19), .Y(n31) );
  OAI2BB2X1M U28 ( .B0(n14), .B1(n39), .A0N(n14), .A1N(n43), .Y(n29) );
  XNOR2X2M U29 ( .A(edge_cnt[0]), .B(Prescale[1]), .Y(n22) );
  NAND4X2M U30 ( .A(n20), .B(n21), .C(n22), .D(n23), .Y(n17) );
  XNOR2X2M U31 ( .A(edge_cnt[2]), .B(Prescale[3]), .Y(n20) );
  XNOR2X2M U32 ( .A(edge_cnt[3]), .B(Prescale[4]), .Y(n21) );
  XNOR2X2M U33 ( .A(edge_cnt[1]), .B(Prescale[2]), .Y(n23) );
  OAI2BB2X1M U34 ( .B0(n11), .B1(n38), .A0N(sampled_bit), .A1N(n38), .Y(n25)
         );
  AOI21X2M U35 ( .A0(samp2), .A1(samp1), .B0(n13), .Y(n11) );
  INVX2M U36 ( .A(dat_samp_en), .Y(n38) );
  OA21X2M U37 ( .A0(samp2), .A1(samp1), .B0(samp3), .Y(n13) );
  CLKINVX1M U38 ( .A(Prescale[1]), .Y(N15) );
  OAI2BB1X1M U39 ( .A0N(Prescale[1]), .A1N(Prescale[2]), .B0(n7), .Y(N16) );
  AO21XLM U40 ( .A0(n8), .A1(Prescale[4]), .B0(N19), .Y(N18) );
  XNOR2X1M U41 ( .A(N17), .B(edge_cnt[2]), .Y(n10) );
  XNOR2X1M U42 ( .A(N18), .B(edge_cnt[3]), .Y(n9) );
  CLKNAND2X2M U43 ( .A(n10), .B(n9), .Y(n32) );
  CLKXOR2X2M U44 ( .A(N16), .B(edge_cnt[1]), .Y(n15) );
  CLKXOR2X2M U45 ( .A(N15), .B(edge_cnt[0]), .Y(n12) );
  XNOR2X1M U46 ( .A(N24), .B(edge_cnt[2]), .Y(n34) );
  XNOR2X1M U47 ( .A(N25), .B(edge_cnt[3]), .Y(n33) );
  CLKNAND2X2M U48 ( .A(n34), .B(n33), .Y(n37) );
  CLKXOR2X2M U49 ( .A(N23), .B(edge_cnt[1]), .Y(n36) );
  CLKXOR2X2M U50 ( .A(N15), .B(edge_cnt[0]), .Y(n35) );
  NOR4X1M U51 ( .A(n37), .B(n36), .C(N26), .D(n35), .Y(N27) );
  DLY1X1M U52 ( .A(samp3), .Y(n43) );
  SDFFRX1M sampled_bit_reg ( .D(n25), .SI(n43), .SE(test_se), .CK(clk), .RN(
        rst), .QN(n1) );
endmodule


module edge_bit_counter_test_1 ( enable, reset_cnt, Prescale, clk, rst, 
        bit_cnt, edge_cnt, test_si, test_so, test_se );
  input [4:0] Prescale;
  output [3:0] bit_cnt;
  output [3:0] edge_cnt;
  input enable, reset_cnt, clk, rst, test_si, test_se;
  output test_so;
  wire   n71, n32, n33, n75, N7, n3, n6, n8, n9, n10, n11, n14, n15, n16, n19,
         n21, n22, n23, n24, n25, n26, n30, n36, n38, n40, n42, n45, n46, n47,
         n1, n4, n7, n13, n18, n27, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n78, n79, n2, n5, n12, n17,
         n20, n29;
  assign test_so = n65;

  INVX4M U3 ( .A(n27), .Y(edge_cnt[0]) );
  INVX2M U4 ( .A(n5), .Y(bit_cnt[2]) );
  NOR4X4M U6 ( .A(n58), .B(n57), .C(Prescale[4]), .D(n56), .Y(N7) );
  INVX2M U8 ( .A(n17), .Y(bit_cnt[3]) );
  INVX4M U10 ( .A(n7), .Y(bit_cnt[1]) );
  INVX4M U12 ( .A(n13), .Y(edge_cnt[1]) );
  INVX4M U14 ( .A(n18), .Y(edge_cnt[2]) );
  INVXLM U15 ( .A(n75), .Y(n27) );
  AOI21X2M U24 ( .A0(n69), .A1(n25), .B0(n68), .Y(n30) );
  INVX2M U25 ( .A(edge_cnt[0]), .Y(n62) );
  INVX2M U26 ( .A(edge_cnt[2]), .Y(n64) );
  INVX2M U27 ( .A(n30), .Y(n61) );
  INVX4M U28 ( .A(enable), .Y(n68) );
  AOI2B1X2M U29 ( .A1N(n10), .A0(n8), .B0(n68), .Y(n9) );
  INVX2M U30 ( .A(n25), .Y(n60) );
  INVX2M U31 ( .A(reset_cnt), .Y(n69) );
  NAND2X3M U32 ( .A(N7), .B(n69), .Y(n25) );
  NOR3X6M U33 ( .A(n25), .B(n61), .C(n66), .Y(n21) );
  AOI21X2M U34 ( .A0(n66), .A1(n60), .B0(n61), .Y(n26) );
  NOR2X6M U35 ( .A(N7), .B(reset_cnt), .Y(n8) );
  OAI22X1M U36 ( .A0(enable), .A1(n62), .B0(n16), .B1(n68), .Y(n42) );
  AOI21X2M U37 ( .A0(n62), .A1(n69), .B0(n60), .Y(n16) );
  OAI21X2M U38 ( .A0(n9), .A1(n64), .B0(n11), .Y(n38) );
  NAND4X2M U39 ( .A(enable), .B(n8), .C(n10), .D(n78), .Y(n11) );
  NOR2X4M U48 ( .A(n79), .B(n63), .Y(n10) );
  OAI32X2M U49 ( .A0(n25), .A1(bit_cnt[0]), .A2(n61), .B0(n30), .B1(n66), .Y(
        n47) );
  OAI21X2M U50 ( .A0(bit_cnt[1]), .A1(n25), .B0(n26), .Y(n22) );
  OAI2BB2X1M U51 ( .B0(n26), .B1(n67), .A0N(n67), .A1N(n21), .Y(n46) );
  INVX2M U52 ( .A(bit_cnt[1]), .Y(n67) );
  OAI21X2M U53 ( .A0(n23), .A1(n17), .B0(n24), .Y(n45) );
  NAND4X2M U54 ( .A(n17), .B(n21), .C(bit_cnt[1]), .D(bit_cnt[2]), .Y(n24) );
  AOI21X2M U55 ( .A0(n60), .A1(n5), .B0(n22), .Y(n23) );
  INVX2M U56 ( .A(n19), .Y(n59) );
  AOI32X1M U57 ( .A0(bit_cnt[1]), .A1(n5), .A2(n21), .B0(n22), .B1(bit_cnt[2]), 
        .Y(n19) );
  OAI32X2M U58 ( .A0(n3), .A1(n64), .A2(n68), .B0(n6), .B1(n65), .Y(n36) );
  NAND3X2M U59 ( .A(n10), .B(n65), .C(n8), .Y(n3) );
  AOI21BX2M U60 ( .A0(n64), .A1(n8), .B0N(n9), .Y(n6) );
  OAI21X2M U62 ( .A0(n14), .A1(n63), .B0(n15), .Y(n40) );
  NAND4X2M U63 ( .A(enable), .B(n8), .C(edge_cnt[0]), .D(n63), .Y(n15) );
  AOI21X2M U64 ( .A0(n8), .A1(n62), .B0(n68), .Y(n14) );
  INVX2M U65 ( .A(edge_cnt[1]), .Y(n63) );
  XNOR2X1M U67 ( .A(Prescale[2]), .B(edge_cnt[2]), .Y(n55) );
  XNOR2X1M U68 ( .A(Prescale[3]), .B(edge_cnt[3]), .Y(n54) );
  CLKNAND2X2M U69 ( .A(n55), .B(n54), .Y(n58) );
  CLKXOR2X2M U70 ( .A(Prescale[1]), .B(edge_cnt[1]), .Y(n57) );
  CLKXOR2X2M U71 ( .A(Prescale[0]), .B(edge_cnt[0]), .Y(n56) );
  INVXLM U72 ( .A(edge_cnt[2]), .Y(n78) );
  SDFFRX1M \edge_cnt_reg[1]  ( .D(n40), .SI(n62), .SE(test_se), .CK(clk), .RN(
        rst), .QN(n13) );
  SDFFRX1M \edge_cnt_reg[2]  ( .D(n38), .SI(n63), .SE(test_se), .CK(clk), .RN(
        rst), .QN(n18) );
  SDFFRX1M \edge_cnt_reg[0]  ( .D(n42), .SI(n17), .SE(test_se), .CK(clk), .RN(
        rst), .Q(n75), .QN(n79) );
  SDFFRX1M \bit_cnt_reg[1]  ( .D(n46), .SI(bit_cnt[0]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n7) );
  SDFFRX1M \bit_cnt_reg[2]  ( .D(n59), .SI(n67), .SE(test_se), .CK(clk), .RN(
        rst), .Q(n71), .QN(n4) );
  SDFFRX1M \bit_cnt_reg[3]  ( .D(n45), .SI(n71), .SE(test_se), .CK(clk), .RN(
        rst), .QN(n1) );
  SDFFRX2M \edge_cnt_reg[3]  ( .D(n36), .SI(n64), .SE(test_se), .CK(clk), .RN(
        rst), .Q(n33), .QN(n65) );
  SDFFRX2M \bit_cnt_reg[0]  ( .D(n47), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(n32), .QN(n66) );
  INVXLM U5 ( .A(n4), .Y(n2) );
  INVX2M U7 ( .A(n2), .Y(n5) );
  INVXLM U9 ( .A(n1), .Y(n12) );
  INVX2M U11 ( .A(n12), .Y(n17) );
  INVXLM U13 ( .A(n32), .Y(n20) );
  INVX4M U16 ( .A(n20), .Y(bit_cnt[0]) );
  INVXLM U17 ( .A(n33), .Y(n29) );
  INVX4M U18 ( .A(n29), .Y(edge_cnt[3]) );
endmodule


module deserializer_test_1 ( deser_en, sampled_bit, clk, rst, edge_cnt, P_DATA, 
        test_se );
  input [3:0] edge_cnt;
  output [7:0] P_DATA;
  input deser_en, sampled_bit, clk, rst, test_se;
  wire   n1, n10, n12, n14, n16, n18, n20, n22, n24, n26, n2, n4, n6, n8, n27,
         n29, n31, n33, n43, n44, n3, n5, n7, n9, n11, n13, n15, n17;

  CLKINVX32M U3 ( .A(n2), .Y(P_DATA[2]) );
  CLKINVX32M U9 ( .A(n8), .Y(P_DATA[0]) );
  CLKINVX32M U11 ( .A(n27), .Y(P_DATA[4]) );
  CLKINVX32M U15 ( .A(n17), .Y(P_DATA[7]) );
  CLKINVX32M U17 ( .A(n33), .Y(P_DATA[6]) );
  INVX4M U34 ( .A(n43), .Y(n44) );
  OAI22X1M U35 ( .A0(n43), .A1(n9), .B0(n44), .B1(n2), .Y(n16) );
  OAI22X1M U36 ( .A0(n43), .A1(n17), .B0(n44), .B1(n33), .Y(n24) );
  OAI22X1M U37 ( .A0(n43), .A1(n2), .B0(n44), .B1(n5), .Y(n14) );
  OAI22X1M U38 ( .A0(n43), .A1(n27), .B0(n44), .B1(n9), .Y(n18) );
  OAI22X1M U39 ( .A0(n43), .A1(n13), .B0(n44), .B1(n27), .Y(n20) );
  OAI22X1M U40 ( .A0(n43), .A1(n33), .B0(n44), .B1(n13), .Y(n22) );
  OAI2BB2X1M U41 ( .B0(n44), .B1(n17), .A0N(sampled_bit), .A1N(n44), .Y(n26)
         );
  OAI2BB2X1M U42 ( .B0(n43), .B1(n5), .A0N(P_DATA[0]), .A1N(n43), .Y(n12) );
  CLKBUFX6M U43 ( .A(n1), .Y(n43) );
  NAND4X2M U44 ( .A(edge_cnt[2]), .B(edge_cnt[1]), .C(n10), .D(deser_en), .Y(
        n1) );
  NOR2X2M U45 ( .A(edge_cnt[3]), .B(edge_cnt[0]), .Y(n10) );
  SDFFRX1M \P_DATA_reg[0]  ( .D(n12), .SI(sampled_bit), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n8) );
  SDFFRX1M \P_DATA_reg[5]  ( .D(n22), .SI(P_DATA[4]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n6) );
  SDFFRX1M \P_DATA_reg[3]  ( .D(n18), .SI(P_DATA[2]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n29) );
  SDFFRX1M \P_DATA_reg[1]  ( .D(n14), .SI(P_DATA[0]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n4) );
  SDFFRX1M \P_DATA_reg[7]  ( .D(n26), .SI(P_DATA[6]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n31) );
  SDFFRX2M \P_DATA_reg[6]  ( .D(n24), .SI(P_DATA[5]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n33) );
  SDFFRX2M \P_DATA_reg[4]  ( .D(n20), .SI(P_DATA[3]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n27) );
  SDFFRX2M \P_DATA_reg[2]  ( .D(n16), .SI(P_DATA[1]), .SE(test_se), .CK(clk), 
        .RN(rst), .QN(n2) );
  CLKINVX32M U2 ( .A(n5), .Y(P_DATA[1]) );
  CLKINVX32M U4 ( .A(n13), .Y(P_DATA[5]) );
  CLKINVX32M U5 ( .A(n9), .Y(P_DATA[3]) );
  INVXLM U6 ( .A(n4), .Y(n3) );
  INVX2M U7 ( .A(n3), .Y(n5) );
  INVXLM U8 ( .A(n29), .Y(n7) );
  INVX2M U10 ( .A(n7), .Y(n9) );
  INVXLM U12 ( .A(n6), .Y(n11) );
  INVX2M U13 ( .A(n11), .Y(n13) );
  INVXLM U14 ( .A(n31), .Y(n15) );
  INVX2M U16 ( .A(n15), .Y(n17) );
endmodule


module parity_check_test_1 ( par_chk_en, sampled_bit, PAR_TYP, P_DATA, clk, 
        rst, par_err, test_si, test_se );
  input [7:0] P_DATA;
  input par_chk_en, sampled_bit, PAR_TYP, clk, rst, test_si, test_se;
  output par_err;
  wire   n1, n3, n4, n5, n6, n9, n2, n11, n12;

  XNOR2X2M U2 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  INVX2M U4 ( .A(n2), .Y(par_err) );
  XNOR3XLM U6 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n11), .Y(n3) );
  XNOR2X2M U7 ( .A(sampled_bit), .B(PAR_TYP), .Y(n5) );
  OAI2BB2X1M U8 ( .B0(n1), .B1(n12), .A0N(par_err), .A1N(n12), .Y(n9) );
  INVX2M U9 ( .A(par_chk_en), .Y(n12) );
  XOR3XLM U11 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  XOR3XLM U12 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n4) );
  CLKXOR2X2M U13 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n11) );
  SDFFRX1M par_err_reg ( .D(n9), .SI(test_si), .SE(test_se), .CK(clk), .RN(rst), .QN(n2) );
endmodule


module strt_check_test_1 ( strt_chk_en, sampled_bit, clk, rst, strt_glitch, 
        test_si, test_se );
  input strt_chk_en, sampled_bit, clk, rst, test_si, test_se;
  output strt_glitch;
  wire   n8, n2, n7;

  AO2B2X2M U4 ( .B0(strt_chk_en), .B1(sampled_bit), .A0(n7), .A1N(strt_chk_en), 
        .Y(n2) );
  DLY1X1M U5 ( .A(n8), .Y(strt_glitch) );
  DLY1X1M U6 ( .A(n8), .Y(n7) );
  SDFFRX1M strt_glitch_reg ( .D(n2), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(rst), .Q(n8) );
endmodule


module Stop_check_test_1 ( stp_chk_en, sampled_bit, clk, rst, stp_err, test_si, 
        test_se );
  input stp_chk_en, sampled_bit, clk, rst, test_si, test_se;
  output stp_err;
  wire   n9, n3, n4, n8;

  OAI2BB2X1M U3 ( .B0(sampled_bit), .B1(n4), .A0N(n8), .A1N(n4), .Y(n3) );
  INVX2M U5 ( .A(stp_chk_en), .Y(n4) );
  DLY1X1M U6 ( .A(n9), .Y(stp_err) );
  DLY1X1M U7 ( .A(n9), .Y(n8) );
  SDFFRX1M stp_err_reg ( .D(n3), .SI(test_si), .SE(test_se), .CK(clk), .RN(rst), .Q(n9) );
endmodule


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  AO2B2X4M U1 ( .B0(SEL), .B1(IN_1), .A0(IN_0), .A1N(SEL), .Y(OUT) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  AO2B2X4M U1 ( .B0(SEL), .B1(IN_1), .A0(IN_0), .A1N(SEL), .Y(OUT) );
endmodule


module UART_RX ( RX_IN, Prescale, PAR_EN, PAR_TYP, CLK, RST, SI, SE, scan_clk, 
        scan_rst, test_mode, SO, data_valid, P_DATA );
  input [4:0] Prescale;
  output [7:0] P_DATA;
  input RX_IN, PAR_EN, PAR_TYP, CLK, RST, SI, SE, scan_clk, scan_rst,
         test_mode;
  output SO, data_valid;
  wire   par_err, strt_glitch, stp_err, enable, par_chk_en, strt_chk_en,
         stp_chk_en, dat_samp_en, deser_en, reset_cnt, sampled_bit, clk_out,
         rst_out, n1, n2, n3, n4, n5, n6, n8, n9;
  wire   [3:0] bit_cnt;
  wire   [3:0] edge_cnt;
  assign SO = strt_glitch;

  BUFX4M U1 ( .A(PAR_EN), .Y(n1) );
  BUFX4M U2 ( .A(Prescale[1]), .Y(n2) );
  BUFX4M U3 ( .A(Prescale[2]), .Y(n3) );
  BUFX4M U4 ( .A(Prescale[3]), .Y(n4) );
  BUFX4M U5 ( .A(Prescale[4]), .Y(n5) );
  BUFX4M U6 ( .A(RX_IN), .Y(n6) );
  FSM_test_1 U_FSM ( .RX_IN(n6), .PAR_EN(n1), .par_err(par_err), .strt_glitch(
        strt_glitch), .stp_err(stp_err), .bit_cnt(bit_cnt), .edge_cnt(edge_cnt), .Clk(clk_out), .RST(rst_out), .enable(enable), .par_chk_en(par_chk_en), 
        .strt_chk_en(strt_chk_en), .stp_chk_en(stp_chk_en), .dat_samp_en(
        dat_samp_en), .deser_en(deser_en), .reset_cnt(reset_cnt), .data_valid(
        data_valid), .test_si(SI), .test_so(n9), .test_se(SE) );
  data_sampling_test_1 U_data_sampling ( .RX_IN(n6), .dat_samp_en(dat_samp_en), 
        .Prescale({n5, n4, n3, n2, Prescale[0]}), .clk(clk_out), .rst(rst_out), 
        .edge_cnt(edge_cnt), .sampled_bit(sampled_bit), .test_si(stp_err), 
        .test_se(SE) );
  edge_bit_counter_test_1 U_edge_bit_counter ( .enable(enable), .reset_cnt(
        reset_cnt), .Prescale({n5, n4, n3, n2, Prescale[0]}), .clk(clk_out), 
        .rst(rst_out), .bit_cnt(bit_cnt), .edge_cnt(edge_cnt), .test_si(
        P_DATA[7]), .test_so(n8), .test_se(SE) );
  deserializer_test_1 U_deserializer ( .deser_en(deser_en), .sampled_bit(
        sampled_bit), .clk(clk_out), .rst(rst_out), .edge_cnt(edge_cnt), 
        .P_DATA(P_DATA), .test_se(SE) );
  parity_check_test_1 U_parity_check ( .par_chk_en(par_chk_en), .sampled_bit(
        sampled_bit), .PAR_TYP(PAR_TYP), .P_DATA(P_DATA), .clk(clk_out), .rst(
        rst_out), .par_err(par_err), .test_si(n8), .test_se(SE) );
  strt_check_test_1 U_strt_check ( .strt_chk_en(strt_chk_en), .sampled_bit(
        sampled_bit), .clk(clk_out), .rst(rst_out), .strt_glitch(strt_glitch), 
        .test_si(par_err), .test_se(SE) );
  Stop_check_test_1 U_Stop_check ( .stp_chk_en(stp_chk_en), .sampled_bit(
        sampled_bit), .clk(clk_out), .rst(rst_out), .stp_err(stp_err), 
        .test_si(n9), .test_se(SE) );
  mux2X1_1 U_Mux_clk ( .IN_0(CLK), .IN_1(scan_clk), .SEL(test_mode), .OUT(
        clk_out) );
  mux2X1_0 U_Mux_rst ( .IN_0(RST), .IN_1(scan_rst), .SEL(test_mode), .OUT(
        rst_out) );
endmodule

