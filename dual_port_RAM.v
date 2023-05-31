module dual_port_RAM (
    input clock,
    input [5:0] address_1, address_2,
    input [7:0] write_data_1, write_data_2,
    input write_enable_1, write_enable_2,
    output reg [7:0] read_data_1, read_data_2
);

reg [7:0] RAM [63:0];

always @(posedge clock) begin
    if (write_enable_1) RAM[address_1] <= write_data_1;
    else read_data_1 <= RAM[address_1];
end

always @(posedge clock) begin
    if (write_enable_2) RAM[address_2] <= write_data_2;
    else read_data_2 <= RAM[address_2];
end
    
endmodule

module Dual_Port_RAM_Test_Bench ();
    
reg [7:0] write_data_1, write_data_2;
reg [5:0] address_1, address_2;
reg write_enable_1, write_enable_2;
reg clock;
wire [7:0] read_data_1, read_data_2;

dual_port_RAM uut(
    .write_data_1(write_data_1),
    .write_data_2(write_data_2),
    .address_1(address_1),
    .address_2(address_2),
    .write_enable_1(write_enable_1),
    .write_enable_2(write_enable_2),
    .clock(clock),
    .read_data_1(read_data_1),
    .read_data_2(read_data_2)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, Dual_Port_RAM_Test_Bench);

    clock = 1'b1;
    forever #5 clock = ~clock;
end

initial begin
    write_data_1 = 8'd9;
    address_1 = 6'd9;
    write_enable_1 = 1'b1;

    write_data_2 = 8'd27;
    address_2 = 6'd27;
    write_enable_2 = 1'b1;

    #10;
    address_1 = 6'd9;
    write_enable_1 = 1'b0;

    address_2 = 6'd27;
    write_enable_2 = 1'b0;
end
    
endmodule