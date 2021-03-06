--TP 1 - Simulation microprocesseur mu0

------------------------------------------------------
--               PORTE 3 ETATS
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tristate is
  port( oe : in std_logic;
        data_in  : in std_logic_vector( 15 downto 0);
        data_out : inout std_logic_vector(15 downto 0));
end tristate;

architecture arch_tristate of tristate is
begin

-----------------------------------
data_out <= data_in when oe = '1'
else (others=>'Z');
-----------------------------------

end arch_tristate;

------------------------------------------------------
--               MULTIPLEXEUR MUX A 3 VOIES
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_A is
  port( sel : in std_logic_vector(1 downto 0);
        e_0, e_1, e_2 : in std_logic_vector(11 downto 0);
        s : out std_logic_vector( 11 downto 0));
end mux_A;

architecture arch_mux_A of mux_A is
  begin

--------------------------
s <= e_0 when sel = "00"
        else e_1 when sel = "01"
        else e_2;
--------------------------

end arch_mux_A;
------------------------------------------------------
--               MULTIPLEXEUR MUX B 2 VOIES
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_B is
  port( sel : in std_logic;
        e_0, e_1 : in std_logic_vector(15 downto 0);
        s : out std_logic_vector( 15 downto 0));
end mux_B;

architecture arch_mux_B of mux_B is
  begin

---------------------------
s <= e_0 when sel = '0'
else e_1;
---------------------------

end arch_mux_B;

------------------------------------------------------
--               MULTIPLEXEUR MUX C 2 VOIES
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_C is
  port( sel : in std_logic;
        e_0, e_1 : in std_logic_vector(11 downto 0);
        s : out std_logic_vector( 11 downto 0));
end mux_C;

architecture arch_mux_C of mux_C is
  begin

---------------------------
s <= e_0 when sel = '0'
else e_1;
---------------------------

end arch_mux_C;


------------------------------------------------------
--          UNITE ARITHMETIQUE ET LOGIQUE
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.up_pack.all;

entity alu is
  port ( A, B : in std_logic_vector(15 downto 0);
          alufs : in ALU_FCTS;
          S : out std_logic_vector( 15 downto 0));
end alu;

architecture arch_alu of alu is

begin

-----------------------------------
S <= B when alufs = ALU_B else
        std_logic_vector(unsigned(A)-unsigned(B)) when alufs = ALU_SUB else
        std_logic_vector(unsigned(A)+unsigned(B)) when alufs = ALU_ADD else
        std_logic_vector(unsigned(B)+1) when alufs = ALU_B_INC else
        A and B when alufs = ALU_AND else
        A or B when alufs = ALU_OR else
        A xor B when alufs = ALU_XOR;
-----------------------------------

end arch_alu;

------------------------------------------------------
--               REGISTRE ACCUMULATEUR
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity accumulator is
  port( clk, raz, load : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0);
        acc15, accz : out std_logic );
end accumulator;

architecture arch_acc of accumulator is
  signal q_reg : std_logic_vector(15 downto 0);
  begin

----------------------------------
process(clk,raz)
  begin
    if raz = '1' then
      q_reg <= (others => '0');
    elsif rising_edge(clk) then
      if load ='1' then
        q_reg <= data_in;
      end if;
    end if;
end process;

accz <= '1' when q_reg = "0000000000000000"
  else '0';

acc15 <= q_reg(15);

data_out <= q_reg;
----------------------------------

end arch_acc;

------------------------------------------------------
--               REGISTRE POINTEUR
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity pointer is
    port(
            clk, raz, load, inc, dec : in std_logic;
            data_in : in std_logic_vector(11 downto 0);
            data_out : out std_logic_vector(11 downto 0)
        );
end pointer;

architecture arch_pointer of pointer is
    signal q_reg : std_logic_vector(11 downto 0);
    begin

----------------------------------
process(clk,raz)
    begin
        if raz = '1' then
        q_reg <= (others => '0');
        elsif rising_edge(clk) then
            if load ='1' then
                q_reg <= data_in;
            elsif inc = '1' then
                q_reg <= std_logic_vector(unsigned(q_reg) + 1);
            elsif dec = '1' then
                q_reg <= std_logic_vector(unsigned(q_reg) - 1);
            end if;
        end if;
end process;

data_out <= q_reg;
----------------------------------

end arch_pointer;

------------------------------------------------------
--               REGISTRE PC
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_reg is
  port( clk, raz, load : in std_logic;
        data_in : in std_logic_vector(11 downto 0);
        data_out : out std_logic_vector(11 downto 0) );
end pc_reg;

architecture arch_pc_reg of pc_reg is
  signal q_reg : std_logic_vector(11 downto 0);
  begin

----------------------------
process(clk,raz)
    begin
        if raz = '1' then
        q_reg <= (others=>'0');
        elsif rising_edge(clk) then
            if load ='1' then
                q_reg <= data_in;
            end if;
        end if;
end process;

data_out <= q_reg;
----------------------------

end arch_pc_reg;


------------------------------------------------------
--               REGISTRE SPC
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spc_reg is
  port( clk, raz, load : in std_logic;
        data_in : in std_logic_vector(11 downto 0);
        data_out : out std_logic_vector(11 downto 0) );
end spc_reg;

architecture arch_spc_reg of spc_reg is
  signal q_reg : std_logic_vector(11 downto 0);
  begin

----------------------------
process(clk,raz)
    begin
        if raz = '1' then
        q_reg <= (others=>'0');
        elsif rising_edge(clk) then
            if load ='1' then
                q_reg <= data_in;
            end if;
        end if;
end process;

data_out <= q_reg;
----------------------------

end arch_spc_reg;



------------------------------------------------------
--               REGISTRE IR (Instruction Register)
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.up_pack.all;

entity ir_reg is
  port( clk, raz, load : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(11 downto 0);
        opcode : out OPCODE);
end ir_reg;

architecture arch_ir_reg of ir_reg is
 signal interne :  std_logic_vector(3 downto 0);
begin

 -------------------------------
 process(clk,raz)
	begin
	if raz = '1' then
		data_out <= (others=>'0');
	elsif rising_edge(clk) then
		if load = '1' then
			interne <= data_in(15 downto 12);
			data_out <= data_in(11 downto 0);
		end if;
	end if;
end process;
 -------------------------------

opcode <= OP_LDA when interne="0000" else
          OP_STO when interne="0001" else
          OP_ADD when interne="0010" else
          OP_SUB when interne="0011" else
          OP_JMP when interne="0100" else
          OP_JGE when interne="0101" else
          OP_JNE when interne="0110" else
          OP_STP when interne="0111" else
          OP_AND when interne="1000" else
          OP_OR  when interne="1001" else
          OP_XOR when interne="1010" else
          OP_LDR when interne="1011" else
          OP_LDI when interne="1100" else
          OP_STI when interne="1101" else
          OP_JSR when interne="1110" else
          OP_RET when interne="1111" else
          OP_UNKNOWN;

end arch_ir_reg;
------------------------------------------------------
--          SEQUENCEUR (deja fourni, � analyser)
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.up_pack.all;

entity sequenceur is
    port( 
            clk, reset : in std_logic;
            accz, acc15 : in std_logic;
            opcode : in OPCODE;
            r_inc, r_dec: out std_logic;
            raz  : out std_logic;
            selA : out std_logic_vector(1 downto 0);
            selB : out std_logic;
			selC : out std_logic;
            acc_ld, pc_ld, ir_ld, acc_oe, r_ld : out std_logic;
            alufs : out ALU_FCTS;
            memrq, rnw : out std_logic;
			spc_ld : out std_logic
        );
end sequenceur;

architecture arch_seq of sequenceur is

  type me_states is (INIT, FETCH, EXECUTE, STOP);
  signal  etat_cr, etat_sv : me_states ;

begin

process( clk , reset)
    begin
        if reset='1' then etat_cr <= INIT;
        elsif rising_edge(clk) then etat_cr <= etat_sv;
        end if;
end process;

process(etat_cr, opcode, accz, acc15)
    begin
        etat_sv <= etat_cr;
        raz <= '0';
        selA <= "00";
        selB <= '0';
		selC <= '1';
		spc_ld <= '0';
        acc_ld <= '0';
        acc_oe <= '0';
        pc_ld <= '0';
        ir_ld <= '0';
        r_ld <= '0';
        alufs <= ALU_B_INC;
        memrq <= '1';
        rnw <='1';
        r_inc <= '0';
        r_dec <= '0';
		

		case etat_cr is
			when INIT =>
				etat_sv <= FETCH;
				raz <= '1';
			when FETCH =>
				etat_sv <= EXECUTE;
				ir_ld <= '1';				-- load IR with data on the data bus
				alufs <= ALU_B_INC;			-- op = B+1
				pc_ld <= '1';				-- load PC with PC+1
			when EXECUTE =>
				case opcode is
					when OP_LDA =>
						selA <= "11"; 		-- IR[mem] on addr bus
						selB <= '1';
 						alufs <= ALU_B;		-- op = B
						acc_ld <= '1';		-- load data in accumulator
						etat_sv <= FETCH;
					when OP_STO =>
						selA <= "11";		-- IR[mem] on addr bus
						acc_oe <= '1';		-- output accumulator on data bus
						rnw <= '0';			-- select write to memory
						etat_sv <= FETCH;
					when OP_ADD =>
						selA <= "11";		-- IR[mem] on addr bus
						selB <= '1';		-- data to B alu entry
						alufs <= ALU_ADD;	-- op = A+B
						acc_ld <= '1';		-- load result in accumulator
						etat_sv <= FETCH;
					when OP_SUB =>
						selA <= "11";		-- IR[mem] on addr bus
						selB <= '1';		-- data to B alu entry
						alufs <= ALU_SUB;	-- op = A-B
						acc_ld <= '1';		-- load result in accumulator
						etat_sv <= FETCH;
					when OP_JMP =>
						selA <= "11";		-- IR[mem] on addr bus
						alufs <= ALU_B;  	-- op = B
						pc_ld <= '1';		-- load PC with IR[mem]
						etat_sv <= FETCH;
					when OP_JGE =>
						if acc15='0' then	-- jump, else nothing
							selA <= "11";		-- IR[mem] on addr bus
							alufs <= ALU_B;		-- op = B
							pc_ld <= '1';		-- load PC with IR[mem]
						end if;
						etat_sv <= FETCH;
					when OP_JNE =>
						if accz='0' then	-- jump, else nothing
							selA <= "11";		-- IR[mem] on addr bus
							alufs <= ALU_B;		-- op = B
							pc_ld <= '1';		-- load PC with IR[mem]
						end if;
						etat_sv <= FETCH;
					when OP_STP =>
						etat_sv <= STOP;
					when OP_AND =>
						selA <= "11";		-- IR[mem] on addr bus
						selB <= '1';		-- data to B alu entry
						alufs <= ALU_AND;	-- op = A and B
						acc_ld <= '1';		-- load result in accumulator
						etat_sv <= FETCH;
					when OP_OR =>
						selA <= "11";		-- IR[mem] on addr bus
						selB <= '1';		-- data to B alu entry
						alufs <= ALU_OR;	-- op = A or B
						acc_ld <= '1';		-- load result in accumulator
						etat_sv <= FETCH;
					when OP_XOR =>
						selA <= "11";		-- IR[mem] on addr bus
						selB <= '1';		-- data to B alu entry
						alufs <= ALU_XOR;	-- op = A xor B
						acc_ld <= '1';      -- load result in accumulator
						etat_sv <= FETCH;
					when OP_LDR =>
						selA <= "11";		-- IR[mem] on addr bus
    			 		selB <= '1';		-- data to B alu entry
						alufs <= ALU_B;		-- op = B
						r_ld <= '1';		-- load result in accumulator
                        etat_sv <= FETCH;
                    when OP_LDI =>
                        selA <= "01";		-- IR[mem] on addr bus
                        selB <= '1';		-- data to B alu entry
                        alufs <= ALU_B;		-- op = B
                        acc_ld <= '1';		-- load result in accumulator
                        r_inc <= '1';
                        etat_sv <= FETCH;
                    when OP_STI =>
						selA <= "01";		-- IR[mem] on addr bus
						acc_oe <= '1';		-- output accumulator on data bus
                        rnw <= '0';			-- select write to memory
                        r_inc <= '1';
						etat_sv <= FETCH;
					when OP_JSR =>
						selA <= "11";		-- IR[mem] on addr bus
						alufs <= ALU_B;  	-- op = B
						pc_ld <= '1';
						spc_ld <= '1';
						etat_sv <= FETCH;
					
					when OP_RET =>
						selC <= '0';		-- IR[mem] on addr bus
						alufs <= ALU_B;  	-- op = B
						pc_ld <= '1';
						etat_sv <= FETCH;
						
						

					when others =>
						etat_sv <= STOP;
				end case;

			when STOP => etat_sv <= STOP;
		end case;

end process;

end arch_seq;

------------------------------------------------------
--       INSTANCIATION : DESCRIPTION DE mu0
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.up_pack.all;
use work.all;

entity mu0 is
    port(
        reset, clk : in std_logic;
        data_bus : inout std_logic_vector(15 downto 0);
        addr_bus : inout   std_logic_vector(11 downto 0);
        mem_rq  :  out   std_logic;
        rnw     :  out   std_logic);
    end mu0;

architecture arch_mu0 of mu0 is
    signal opcode		: OPCODE;									-- opcode operation
	signal raz		: std_logic;			                    -- raz for registers
	signal ir_out	: std_logic_vector(11 downto 0);	 	    -- output of IR
	signal r_out	: std_logic_vector(11 downto 0);	 	    -- output of IR
	signal pc_out	: std_logic_vector(11 downto 0);		   	-- output of PC
	signal spc_out	: std_logic_vector(11 downto 0);
	signal alu_out	: std_logic_vector(15 downto 0);	 		-- output of ALU
	signal acc_out	: std_logic_vector(15 downto 0);	 		-- output of ACC
	signal muxb_out	: std_logic_vector(15 downto 0);	-- output of MUXb
	signal muxc_out	: std_logic_vector(11 downto 0);
	signal concat	: std_logic_vector(15 downto 0);
	signal alufs	: ALU_FCTS;		-- function code for alu
	signal ir_ld	: std_logic;	-- load IR
	signal pc_ld	: std_logic;	-- load PC
	signal r_ld	    : std_logic;	-- load R
	signal spc_ld	: std_logic;
	signal acc_ld	: std_logic;	-- load ACC
	signal acc_oe	: std_logic;	-- enable out buffer
	signal selA		: std_logic_vector(1 downto 0);	-- multiplexer A select
	signal selB		: std_logic;	-- multiplexer B select
	signal selC		: std_logic;
	signal accZ		: std_logic;	-- accumulator all zero's
    signal acc15	: std_logic;	-- accumualtor sign bit
    signal r_inc	: std_logic;
    signal r_dec	: std_logic;
    signal muxB_in  : std_logic_vector(15 downto 0);
    signal pc_in    : std_logic_vector(11 downto 0);
	
	
begin

    tristate_comp : entity tristate port map (
        oe => acc_oe,
        data_in => acc_out,
        data_out => data_bus
    );

    mux_A_comp : entity mux_A port map(
        sel => selA,
        e_0 => pc_out,
        e_1 => r_out,
        e_2 => ir_out,
        s => addr_bus
    );

    mux_B_comp : entity mux_B port map(
        sel => selB,
        e_0 => muxB_in,
        e_1 => data_bus,
        s => muxb_out
    );

    muxB_in <= "0000" & muxc_out;

	mux_C_comp : entity mux_C port map(
		sel => selC,
		e_0 => spc_out,
		e_1 => addr_bus,
		s => muxc_out
	);
	
	
	spc_comp : entity spc_reg port map (
		clk => clk,
        raz => raz,
        load => spc_ld,
        data_in => pc_out,
        data_out => spc_out
	
	);
	
    alu_comp : entity alu port map(
        A => acc_out,
        B => muxb_out,
        alufs => alufs,
        S => alu_out
    );

    accumulator_comp : entity accumulator port map(
        clk => clk,
        raz => raz,
        load => acc_ld,
        data_in => alu_out,
        data_out => acc_out,
        acc15 => acc15,
        accz => accZ
    );

    pc_reg_comp : entity pc_reg port map(
        clk => clk,
        raz => raz,
        load => pc_ld,
        data_in => pc_in,
        data_out => pc_out
    );

    pc_in <= alu_out(11 downto 0);

    pointer_comp : entity pointer port map(
        clk => clk,
        raz => raz,
        load => r_ld,
        data_in => pc_in,
        data_out => r_out,
        inc => r_inc,
        dec => r_dec
    );

    ir_reg_comp : entity ir_reg port map(
        clk => clk,
        raz => raz,
        load => ir_ld,
        data_in => data_bus,
        data_out => ir_out,
        opcode => opcode
    );

    sequenceur_comp : entity sequenceur port map(
        clk => clk,
        reset => reset,
        accz => accZ,
        acc15 => acc15,
        r_inc => r_inc,
        r_dec => r_dec,
        opcode => opcode,
        raz => raz,
        selA => selA,
        selB => selB,
		selC => selC,
        acc_ld => acc_ld,
        pc_ld => pc_ld,
        ir_ld => ir_ld,
        r_ld => r_ld,
        acc_oe => acc_oe,
        alufs => alufs,
        memrq => mem_rq,
        rnw => rnw,
		spc_ld => spc_ld
    );

end arch_mu0 ;