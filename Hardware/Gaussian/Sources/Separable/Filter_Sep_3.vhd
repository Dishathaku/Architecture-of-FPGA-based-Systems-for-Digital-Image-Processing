-----------------------------------------------------------
-- Project: Gaussian Filter
-- Author: Guilherme Sborz
-- Date: 15/08/2019
-- File: Filter_Sep_3.vhd

-- Fixed-Point MAC
-- 3x3 kernel
-- pipeline
-- No reorganization on multipliers
-----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Package_Fixed.all;
use work.Package_Constant.all;
use work.Package_Gaussian.all;

entity Filter_Sep_3 is
  generic(
    p_FILTER_SIZE : integer -- Kernel Height (Vertical) or Kernel Width (Horizontal)
  );
  port(
    i_CLK			: in std_logic;
  	i_RST			: in std_logic;
    i_ENA_REG : in std_logic;
    i_KERNEL 	: in fixed_vector(p_FILTER_SIZE-1 downto 0);
    i_WEIGHTS : in fixed_vector(p_FILTER_SIZE-1 downto 0);
  	o_RESULT 	: out fixed
  );
  end entity Filter_Sep_3;

architecture arch of Filter_Sep_3 is

  signal w_BUF_ENA_WRI : std_logic := '0';

  signal w_STAGE_0 : fixed_vector(2 downto 0);  -- Kernel * weights
  signal w_STAGE_1 : fixed_vector(1 downto 0);

  signal r_REG_0 : fixed_vector(2 downto 0);
  signal r_REG_1 : fixed_vector(1 downto 0);

  signal r_REG_3_S1 : fixed;

  begin
    -- Enable load in the barrier registers
    shift_left_signals : process(i_CLK, i_ENA_REG)
    begin
        if(rising_edge(i_CLK)) then
          w_BUF_ENA_WRI <= i_ENA_REG;
        end if;
    end process;

    -- MULTIPLICATION
------------------------------ STAGE 0 -----------------------------------------
    g_STAGE_0 : for i in 0 to 2 generate
      w_STAGE_0(i) <= i_KERNEL(i) * i_WEIGHTS(i);

			Reg_S0 : Reg
			port map (
			  i_CLK  => i_CLK,
			  i_RST  => i_RST,
			  i_ENA  => i_ENA_REG,
			  i_CLR  => '0',
			  i_DIN  => w_STAGE_0(i),
			  o_DOUT => r_REG_0(i)
			);
    end generate;
------------------------------ STAGE 1 -----------------------------------------
      w_STAGE_1(0) <= r_REG_0(0) + r_REG_0(1);
      w_STAGE_1(1) <= r_REG_0(2);


    g_STAGE_1 : for i in 0 to 1 generate

      Reg_S1 : Reg
      port map (
        i_CLK  => i_CLK,
        i_RST  => i_RST,
        i_ENA  => w_BUF_ENA_WRI,
        i_CLR  => '0',
        i_DIN  => w_STAGE_1(i),
        o_DOUT => r_REG_1(i)
      );
    end generate;

    o_RESULT <= r_REG_1(0) + r_REG_1(1);
    
end architecture;
