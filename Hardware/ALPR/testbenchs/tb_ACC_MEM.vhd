library ieee;
use ieee.std_logic_1164.all;

library work;
use work.ALPR_package.all;

use std.textio.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_ACC_MEM is
end entity;

architecture arch of tb_ACC_MEM is
    constant period     : time      := 10 ps;
    signal   cycles     : integer   :=  0;
    signal   rst        : std_logic := '1';
    signal   clk        : std_logic := '0';
    file     fil_in     : text;
    file     fil_out    : text;

    signal pix_in   : std_logic_vector(7 downto 0);
    signal pix_out  : std_logic_vector(31 downto 0);
    signal done : std_logic :=  '0';

begin
    clk   <= not clk after period/2;
    rst   <= '0' after period*2;

p_CNT_CYCLES: process
    variable v_cycles : integer := 0;
    --variable v_pix_in : std_logic_vector(23 downto 0) := x"000000";
    begin
        wait for period/2;
        --while done = '0' loop
            cycles <= v_cycles;
            --pix_in <= v_pix_in;
            v_cycles := v_cycles + 1;
            --v_pix_in := v_pix_in + 1;
            wait for period/2;
        --end loop;
end process;

p_READ : process
    variable v_line : line;
    variable v_data : std_logic_vector(c_WIDTH_DATA_MO1-1 downto 0);

    begin
    wait for period*2;
    file_open(fil_in, "../../Data/MKE-6858_MO1_out.txt", READ_MODE);
    while not endfile(fil_in) loop
      readline(fil_in, v_LINE);
      read(v_LINE, v_data);
      pix_in <= v_data;
      wait for period;
    end loop;
    done <= '1';
    wait;
  end process;

-- p_WRITE : process
--   variable v_line : line;
-- begin
--   wait for period;
--   file_open(fil_out, "../../Data/MKE-6858_Histogram.txt", WRITE_MODE);
--   while not endfile(fil_in) loop
--     if rising_edge(clk) then
--         write(v_line, pix_out);
--         writeline(fil_out, v_line);
--    end if;
--    wait for period;
--   end loop;
--
--   wait;
-- end process;

ACC_MEM_i : ACC_MEM
generic map (
  c_SIZE_MEM   => 256,
  c_WIDTH_DATA => 32,
  c_WIDTH_ADDR => 8
)
port map (
  i_CLK     => clk,
  i_RST     => rst,
  i_WRI_ENA => '1',
  i_ADDR    => pix_in,
  o_ACC     => pix_out
);


end architecture;