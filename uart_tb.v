module uart_tb;
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] data_in;
    wire tx_wire;
    wire busy;
    wire [7:0] data_out;
    wire done;
    uart_tx TX(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .data_in(data_in),
        .tx(tx_wire),
        .busy(busy)
    );
    uart_rx RX(
        .clk(clk),
        .rst(rst),
        .rx(tx_wire),
        .data_out(data_out),
        .done(done)
    );
    always #5 clk = ~clk;
    initial
    begin
    clk = 0;
    rst = 1;
    tx_start = 0;
    data_in = 8'b10101010;
    #20;
    rst = 0;
    #10;
    tx_start = 1;
    #10;
    tx_start = 0;
    #200;
    $display("Received Data = %b", data_out);
    $finish;
    end
endmodule