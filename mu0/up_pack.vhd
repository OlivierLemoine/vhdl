--TP1 mu0 - bibliotheque necessaire au fonctionnement de l'ALU

------------------------------------------------------
--               PACKAGE up_pack
--                    ALU
--
--   alufs   | operation |  Nom
-- ------------------------------------------
--  0 0 0 0  | B         |  ALU_B
--  0 0 0 1  | A-B       |  ALU_SUB
--  0 0 1 0  | A+B       |  ALU_ADD
--  0 0 1 1  | B+1       |  ALU_B_INC
--  0 1 0 0  | A and B   |  ALU_AND
--  0 1 0 1  | A or B    |  ALU_OR
--  0 1 1 0  | A xor B   |  ALU_XOR
--
------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package up_pack is 
	
type ALU_FCTS is
(ALU_B, ALU_SUB, ALU_ADD, ALU_B_INC, ALU_AND, ALU_OR, ALU_XOR);

type OPCODE is(
  OP_LDA,
  OP_STO,
  OP_ADD,
  OP_SUB,
  OP_JMP,
  OP_JGE,
  OP_JNE,
  OP_STP,
  OP_AND,
  OP_OR,
  OP_XOR,
  OP_LDR,
  OP_LDI,
  OP_STI,
  OP_JSR,
  OP_RET,
  OP_UNKNOWN);

end up_pack;

package body up_pack is  
  
end up_pack;
