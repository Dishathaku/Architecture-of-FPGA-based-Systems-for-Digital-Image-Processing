library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.Package_Fixed.all;

package Package_Constant is

------------------------------------ 16 bits -----------------------------------
  constant c_Gaussian_Kernel_3 : fixed_vector(8 downto 0) := (
    0=> x"0013", 1=> x"0020", 2=> x"0013",
    3=> x"0020", 4=> x"0034", 5=> x"0020",
    6=> x"0013", 7=> x"0020", 8=> x"0013"
  );

  constant c_Gaussian_Kernel_5 : fixed_vector(24 downto 0) := (
    0=> x"0001",  1=> x"0003",  2=> x"0006",  3=> x"0003",  4=> x"0001",
    5=> x"0003",  6=> x"000f",  7=> x"0019",  8=> x"000f",  9=> x"0003",
    10=> x"0006", 11=> x"0019", 12=> x"0029", 13=> x"0019", 14=> x"0006",
    15=> x"0003", 16=> x"000f", 17=> x"0019", 18=> x"000f", 19=> x"0003",
    20=> x"0001", 21=> x"0003", 22=> x"0006", 23=> x"0003", 24=> x"0001"
  );

  constant c_Gaussian_Kernel_7 : fixed_vector(48 downto 0) := (
    0=> x"0000",  1=> x"0000", 2=> x"0000",  3=> x"0000",   4=> x"0000",  5=> x"0000",  6=> x"0000",
    7=> x"0000",  8=> x"0001", 9=> x"0003",  10=> x"0006",  11=> x"0003", 12=> x"0001", 13=> x"0000",
    14=> x"0000", 15=> x"0003", 16=> x"000f", 17=> x"0019", 18=> x"000f", 19=> x"0003", 20=> x"0000",
    21=> x"0000", 22=> x"0006", 23=> x"0019", 24=> x"0029", 25=> x"0019", 26=> x"0006", 27=> x"0000",
    28=> x"0000", 29=> x"0003", 30=> x"000f", 31=> x"0019", 32=> x"000f", 33=> x"0003", 34=> x"0000",
    35=> x"0000", 36=> x"0001", 37=> x"0003", 38=> x"0006", 39=> x"0003", 40=> x"0001", 41=> x"0000",
    42=> x"0000", 43=> x"0000", 44=> x"0000", 45=> x"0000", 46=> x"0000", 47=> x"0000", 48=> x"0000"
  );
------------------------------------ 14 bits -----------------------------------
  -- constant c_Gaussian_Kernel_3 : fixed_vector(8 downto 0) := (
  --   0=>"00000000000101", 1=>"00000000001000", 2=>"00000000000101",
  --   3=>"00000000001000", 4=>"00000000001101", 5=>"00000000001000",
  --   6=>"00000000000101", 7=>"00000000001000", 8=>"00000000000101"
  -- );
  --
  -- constant c_Gaussian_Kernel_5 : fixed_vector(24 downto 0) := (
  --   0=> "00000000000000",  1=>"00000000000001",   2=> "00000000000001",  3=>"00000000000001",  4=>"00000000000000",
  --   5=> "00000000000001",  6=>"00000000000100",   7=> "00000000000110",  8=>"00000000000100",  9=>"00000000000001",
  --   10=>"00000000000001", 11=>"00000000000110", 12=>  "00000000001010", 13=>"00000000000110", 14=>"00000000000001",
  --   15=>"00000000000001", 16=>"00000000000100", 17=>  "00000000000110", 18=>"00000000000100", 19=>"00000000000001",
  --   20=>"00000000000000", 21=>"00000000000001", 22=>  "00000000000001", 23=>"00000000000001", 24=>"00000000000000"
  -- );
  --
  -- constant c_Gaussian_Kernel_7 : fixed_vector(48 downto 0) := (
  --   0=> "00000000000000",  1=> "00000000000000",  2=> "00000000000000", 3=>"00000000000000",
  --   4=> "00000000000000",  5=> "00000000000000",  6=> "00000000000000",
  --   7=> "00000000000000",  8=> "00000000000000",  9=> "00000000000001",
  --   10=>"00000000000001", 11=>"00000000000001", 12=>"00000000000000",
  --   13=>"00000000000000", 14=>"00000000000000", 15=>"00000000000001",
  --   16=>"00000000000100", 17=>"00000000000110", 18=>"00000000000100",
  --   19=>"00000000000001", 20=>"00000000000000", 21=>"00000000000000",
  --   22=>"00000000000001", 23=>"00000000000110", 24=>"00000000001010",
  --   25=>"00000000000110", 26=>"00000000000001", 27=>"00000000000000",
  --   28=>"00000000000000", 29=>"00000000000001", 30=>"00000000000100",
  --   31=>"00000000000110", 32=>"00000000000100", 33=>"00000000000001",
  --   34=>"00000000000000", 35=>"00000000000000", 36=>"00000000000000",
  --   37=>"00000000000001", 38=>"00000000000001", 39=>"00000000000001",
  --   40=>"00000000000000", 41=>"00000000000000", 42=>"00000000000000",
  --   43=>"00000000000000", 44=>"00000000000000", 45=>"00000000000000",
  --   46=>"00000000000000", 47=>"00000000000000", 48=>"00000000000000"
  -- );
------------------------------------ 12 bits -----------------------------------
  -- constant c_Gaussian_Kernel_3 : fixed_vector(8 downto 0) := (
  --   0=> x"001", 1=> x"002", 2=> x"001",
  --   3=> x"002", 4=> x"003", 5=> x"002",
  --   6=> x"001", 7=> x"002", 8=> x"001"
  -- );
  --
  -- constant c_Gaussian_Kernel_5 : fixed_vector(24 downto 0) := (
  --   0=>   x"000", 1=>   x"000", 2=>   x"000", 3=>   x"000", 4=>   x"000",
  --   5=>   x"000", 6=>   x"001", 7=>   x"002", 8=>   x"001", 9=>   x"000",
  --   10=>  x"000", 11=>  x"002", 12=>  x"003", 13=>  x"002", 14=>  x"000",
  --   15=>  x"000", 16=>  x"001", 17=>  x"002", 18=>  x"001", 19=>  x"000",
  --   20=>  x"000", 21=>  x"000", 22=>  x"000", 23=>  x"000", 24=>  x"000"
  -- );
  --
  -- constant c_Gaussian_Kernel_7 : fixed_vector(48 downto 0) := (
  --   0=>   x"000", 1=>   x"000", 2=>   x"000", 3=>   x"000", 4=>   x"000", 5=>   x"000", 6=>   x"000",
  --   7=>   x"000", 8=>   x"000", 9=>   x"000", 10=>  x"000", 11=>  x"000", 12=>  x"000", 13=>  x"000",
  --   14=>  x"000", 15=>  x"000", 16=>  x"001", 17=>  x"002", 18=>  x"001", 19=>  x"000", 20=>  x"000",
  --   21=>  x"000", 22=>  x"000", 23=>  x"002", 24=>  x"003", 25=>  x"002", 26=>  x"000", 27=>  x"000",
  --   28=>  x"000", 29=>  x"000", 30=>  x"001", 31=>  x"002", 32=>  x"001", 33=>  x"000", 34=>  x"000",
  --   35=>  x"000", 36=>  x"000", 37=>  x"000", 38=>  x"000", 39=>  x"000", 40=>  x"000", 41=>  x"000",
  --   42=>  x"000", 43=>  x"000", 44=>  x"000", 45=>  x"000", 46=>  x"000", 47=>  x"000", 48=>  x"000"
  -- );

end Package_Constant;