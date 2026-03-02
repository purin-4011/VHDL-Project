library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_seg_decoder is
    Port (
        bin_in : in  std_logic_vector(3 downto 0);
        seg_out: out std_logic_vector(6 downto 0)
    );
end seven_seg_decoder;

architecture behavioral of seven_seg_decoder is
begin

    seg_out <= "1111111"; -- blank (placeholder)

end behavioral;
