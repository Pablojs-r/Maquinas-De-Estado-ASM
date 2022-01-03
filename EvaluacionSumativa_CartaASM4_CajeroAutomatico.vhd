----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:51 01/02/2022 
-- Design Name: 
-- Module Name:    CartaASM4_CajeroAutomatico - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CartaASM4_CajeroAutomatico is
    Port ( clk,VT,VC,VD,intentos : in  STD_LOGIC;
           IT,IC,IM,ET,RT : out  STD_LOGIC;
           Q2,Q1,Q0 : inout  STD_LOGIC);
end CartaASM4_CajeroAutomatico;

architecture Behavioral of CartaASM4_CajeroAutomatico is

    type estados is (A,B,C,D,E,F);
    signal edo_pres, edo_fut: estados;
begin
    p_estados: process(edo_pres,VT,VC,VD,intentos) begin
	     case edo_pres is
		       when A => IT<= '1'; IC<='0' ; IM<= '0'; ET<= '0' ; RT<= '0' ; Q2<='0' ; Q1<= '0'; Q0<= '0';
				     if(VT ='1') then
					    edo_fut <=B;
					  else 
					    edo_fut <=A;
					  end if;
			    when B => IT<= '0'; IC<='1' ; IM<= '0'; ET<= '0' ; RT<= '0' ; Q2<='0' ; Q1<= '0'; Q0<= '1';
				     if(intentos ='1') then
					    edo_fut <=C;
					  else 
					    edo_fut <=A;
					  end if;
		       when C => IT<= '0'; IC<='0' ; IM<= '0'; ET<= '0' ; RT<= '0' ; Q2<='0' ; Q1<= '1'; Q0<= '0';
				     if(VC ='1') then
					    edo_fut <=D;
					  else 
					    edo_fut <=B;
					  end if;
		       when D => IT<= '0'; IC<='0' ; IM<= '1'; ET<= '0' ; RT<= '0' ; Q2<='0' ; Q1<= '1'; Q0<= '1';
				     if(VD ='1') then
					    edo_fut <=E;
					  else 
					    edo_fut <=A;
					  end if;
		       when E => IT<= '0'; IC<='0' ; IM<= '0'; ET<= '1' ; RT<= '0' ; Q2<='1' ; Q1<= '0'; Q0<= '0';
					    edo_fut <=F;
		       when F => IT<= '0'; IC<='0' ; IM<= '0'; ET<= '0' ; RT<= '1' ; Q2<='1' ; Q1<= '0'; Q0<= '1';
					    edo_fut <=A;
		  end case;
	 end process p_estados;
	 
	 p_reloj: process(clk) begin
	     if(clk'event and clk='1') then
	        edo_pres <= edo_fut;
		  end if;
	 end process p_reloj;


end Behavioral;

