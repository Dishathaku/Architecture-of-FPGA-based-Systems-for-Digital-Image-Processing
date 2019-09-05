----------------------------------------------------------------
-- Project: ALPR
-- Author:  Guilherme Sborz
-- Date:    19/02/2019
-- File:    Top_MC_Pipeline.vhd

-- TOP block for morphological closing operations
-- Implement both erode and dilate operations
-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.ALPR_package.all;

entity Top_MC_Pipeline is
    generic(
        c_KERNEL_HEIGHT    : integer := c_KERNEL_HEIGHT_MC;
        c_KERNEL_WIDTH     : integer := c_KERNEL_WIDTH_MC;
        c_INPUT_IMG_WIDTH  : integer := c_INPUT_IMG_WIDTH_MC;
        c_INPUT_IMG_HEIGHT : integer := c_INPUT_IMG_HEIGHT_MC
    );
    port(
        i_CLK         : in  std_logic;
        i_RST         : in  std_logic;
        i_START       : in  std_logic;
        i_VALID_PIXEL : in  std_logic;
        i_INPUT_PIXEL : in  std_logic;
        o_PIX_RDY     : out std_logic;
        o_DONE        : out std_logic;
        o_OUT_PIXEL   : out std_logic
    );
end Top_MC_Pipeline;

architecture arch of Top_MC_Pipeline is

    signal w_OUT_PIX_DIL             : std_logic;
    signal w_OUT_REG                 : std_logic;
    signal w_DONE_1ST_OP             : std_logic;
    signal w_MAX_STAGES              : std_logic;
    signal w_VALID_PIXEL_1ST_OP      : std_logic;
    signal w_VALID_PIXEL_1ST_OP_CTRL : std_logic;
    signal w_VALID_PIXEL_2ND_OP      : std_logic;
    signal w_PIX_RDY_1ST_OP          : std_logic;
    signal w_PIX_RDY_1ST_OP_CTRL     : std_logic;
    signal w_DONE_2ND_OP             : std_logic;

    constant c_DILATED_IMG_WIDTH  : integer := c_INPUT_IMG_WIDTH   - (c_KERNEL_WIDTH  - 1);
    constant c_DILATED_IMG_HEIGHT : integer := c_INPUT_IMG_HEIGHT  - (c_KERNEL_HEIGHT - 1);

begin

    w_VALID_PIXEL_1ST_OP <= i_VALID_PIXEL and w_VALID_PIXEL_1ST_OP_CTRL;
    w_VALID_PIXEL_2ND_OP <= w_PIX_RDY_1ST_OP or w_PIX_RDY_1ST_OP_CTRL;

    DILATION : Top_Operation_MC
    generic map (
      c_KERNEL_HEIGHT    => c_KERNEL_HEIGHT,
      c_KERNEL_WIDTH     => c_KERNEL_WIDTH,
      c_INPUT_IMG_WIDTH  => c_INPUT_IMG_WIDTH,
      c_INPUT_IMG_HEIGHT => c_INPUT_IMG_HEIGHT,
      s_SEL_OPERATION    => 1
    )
    port map (
      i_CLK         => i_CLK,
      i_RST         => i_RST,
      i_START       => i_START,
      i_VALID_PIXEL => w_VALID_PIXEL_1ST_OP, -- Signal coming from the Pipeline control
      i_INPUT_PIXEL => i_INPUT_PIXEL,
      o_PIX_RDY     => w_PIX_RDY_1ST_OP,
      o_DONE        => w_DONE_1ST_OP,
      o_OUT_PIXEL   => w_OUT_PIX_DIL
    );

    EROSION : Top_Operation_MC
    generic map (
      c_KERNEL_HEIGHT    => c_KERNEL_HEIGHT,
      c_KERNEL_WIDTH     => c_KERNEL_WIDTH,
      c_INPUT_IMG_WIDTH  => c_DILATED_IMG_WIDTH,
      c_INPUT_IMG_HEIGHT => c_DILATED_IMG_HEIGHT,
      s_SEL_OPERATION    => 0
    )
    port map (
      i_CLK         => i_CLK,
      i_RST         => i_RST,
      i_START       => w_PIX_RDY_1ST_OP,
      i_VALID_PIXEL => w_VALID_PIXEL_2ND_OP, -- Logic OR between signal coming from the other operation(valid pixel) and signal from Pipeline control
      i_INPUT_PIXEL => w_OUT_REG,
      o_PIX_RDY     => o_PIX_RDY,
      o_DONE        => w_DONE_2ND_OP,
      o_OUT_PIXEL   => o_OUT_PIXEL
    );

    FF_i : Flip_Flop
    port map (
      i_CLK  => i_CLK,
      i_RST  => i_RST,
      i_ENA  => w_VALID_PIXEL_2ND_OP,
      i_CLR  => '0',
      i_DIN  => w_OUT_PIX_DIL,
      o_DOUT => w_OUT_REG
    );

    Control_Top_Pipeline_i : Control_Top_Pipeline
    port map (
      i_CLK                => i_CLK,
      i_RST                => i_RST,
      i_START              => i_START,
      i_DONE_1_OP          => w_DONE_1ST_OP,
      i_DONE_2_OP          => w_DONE_2ND_OP,
      o_PIX_RDY_1_OP       => w_PIX_RDY_1ST_OP_CTRL,
      o_VALID_PIXEL_1ST_OP => w_VALID_PIXEL_1ST_OP_CTRL,
      o_DONE               => o_DONE
    );

end architecture;
