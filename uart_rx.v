module uart_rx(
        input clk,
        input rst,
        input rx,
        output reg [7:0] data_out,
        output reg done
    );
    reg [3:0] bit_count;
    reg receiving;
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            bit_count <= 0;
            receiving <= 0;
            done <= 0;
            data_out <= 0;
        end
        else
        begin
            done <= 0;
            if(!receiving && rx == 0)
            begin
                receiving <= 1;
                bit_count <= 0;
            end
            else if(receiving)
            begin
                if(bit_count < 8)
                begin
                    data_out[bit_count] <= rx;
                    bit_count <= bit_count + 1;
                end
                else
                begin
                    receiving <= 0;
                    done <= 1;
                end
            end
        end
    end
endmodule