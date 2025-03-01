#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst_n", 1, hls_in, -1, "", "", 1),
	Port_Property("bram1_Addr_A", 32, hls_out, 0, "bram", "mem_address", 1),
	Port_Property("bram1_EN_A", 1, hls_out, 0, "bram", "mem_ce", 1),
	Port_Property("bram1_WEN_A", 4, hls_out, 0, "bram", "mem_we", 1),
	Port_Property("bram1_Din_A", 32, hls_out, 0, "bram", "mem_din", 1),
	Port_Property("bram1_Dout_A", 32, hls_in, 0, "bram", "mem_dout", 1),
	Port_Property("bram1_Clk_A", 1, hls_out, 0, "bram", "mem_clk", 1),
	Port_Property("bram1_Rst_A", 1, hls_out, 0, "bram", "mem_rst", 1),
	Port_Property("bram2_Addr_A", 32, hls_out, 1, "bram", "mem_address", 1),
	Port_Property("bram2_EN_A", 1, hls_out, 1, "bram", "mem_ce", 1),
	Port_Property("bram2_WEN_A", 4, hls_out, 1, "bram", "mem_we", 1),
	Port_Property("bram2_Din_A", 32, hls_out, 1, "bram", "mem_din", 1),
	Port_Property("bram2_Dout_A", 32, hls_in, 1, "bram", "mem_dout", 1),
	Port_Property("bram2_Clk_A", 1, hls_out, 1, "bram", "mem_clk", 1),
	Port_Property("bram2_Rst_A", 1, hls_out, 1, "bram", "mem_rst", 1),
	Port_Property("bram3_Addr_A", 32, hls_out, 2, "bram", "mem_address", 1),
	Port_Property("bram3_EN_A", 1, hls_out, 2, "bram", "mem_ce", 1),
	Port_Property("bram3_WEN_A", 4, hls_out, 2, "bram", "mem_we", 1),
	Port_Property("bram3_Din_A", 32, hls_out, 2, "bram", "mem_din", 1),
	Port_Property("bram3_Dout_A", 32, hls_in, 2, "bram", "mem_dout", 1),
	Port_Property("bram3_Clk_A", 1, hls_out, 2, "bram", "mem_clk", 1),
	Port_Property("bram3_Rst_A", 1, hls_out, 2, "bram", "mem_rst", 1),
	Port_Property("bram4_Addr_A", 32, hls_out, 3, "bram", "mem_address", 1),
	Port_Property("bram4_EN_A", 1, hls_out, 3, "bram", "mem_ce", 1),
	Port_Property("bram4_WEN_A", 4, hls_out, 3, "bram", "mem_we", 1),
	Port_Property("bram4_Din_A", 32, hls_out, 3, "bram", "mem_din", 1),
	Port_Property("bram4_Dout_A", 32, hls_in, 3, "bram", "mem_dout", 1),
	Port_Property("bram4_Clk_A", 1, hls_out, 3, "bram", "mem_clk", 1),
	Port_Property("bram4_Rst_A", 1, hls_out, 3, "bram", "mem_rst", 1),
	Port_Property("weight_Addr_A", 32, hls_out, 4, "bram", "mem_address", 1),
	Port_Property("weight_EN_A", 1, hls_out, 4, "bram", "mem_ce", 1),
	Port_Property("weight_WEN_A", 4, hls_out, 4, "bram", "mem_we", 1),
	Port_Property("weight_Din_A", 32, hls_out, 4, "bram", "mem_din", 1),
	Port_Property("weight_Dout_A", 32, hls_in, 4, "bram", "mem_dout", 1),
	Port_Property("weight_Clk_A", 1, hls_out, 4, "bram", "mem_clk", 1),
	Port_Property("weight_Rst_A", 1, hls_out, 4, "bram", "mem_rst", 1),
	Port_Property("s_axi_BUS_CTRL_AWVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_AWREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_AWADDR", 4, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_WVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_WREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_WDATA", 32, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_WSTRB", 4, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_ARVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_ARREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_ARADDR", 4, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_RVALID", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_RREADY", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_RDATA", 32, hls_out, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_RRESP", 2, hls_out, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_BVALID", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_BREADY", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_BUS_CTRL_BRESP", 2, hls_out, -1, "", "", 1),
	Port_Property("interrupt", 1, hls_out, -1, "", "", 1),
};
const char* HLS_Design_Meta::dut_name = "predictor3";
