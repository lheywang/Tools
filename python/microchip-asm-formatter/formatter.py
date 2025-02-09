from math import ceil
import argparse

class Line:
    def __init__(self, Type, Instr, Args, Comments):
        self.Type = Type
        self.Instr = Instr
        self.Args = Args
        self.Comments = Comments
    
    def __repr__(self):
        return f"Line : {self.Type} --> {self.Instr}, {self.Args} ; {self.Comments}"

# Main formatting function !
def Format(Input, CreateCopy):
    lines = []

    with open(Input[:-4] + ".asm","r") as f:
        lines = f.readlines()

    if CreateCopy == True:
        with open(Input[:-4] + "_raw.asm", "w+") as f:
            for line in lines:
                f.write(line)

    # Splits to spaces (--> Works fine !)
    for index, line in enumerate(lines):
        lines[index] = line.split(" ")

    # Remove empty chars
    for index, line in enumerate(lines):
        while "" in lines[index]:
            lines[index].remove("")
        while "\t" in lines[index]:
            lines[index].remove("\t")

    # Remove useless chars over previous list
    for index, line in enumerate(lines):
        for index2, token in enumerate(line):
            lines[index][index2] = token.strip()

    # Now, printing everything...
    output = []

    for index, line in enumerate(lines):
        # Get functions and labels :
        if len(line) == 1 and line[0].endswith(":"):
            output.append(Line("FUNC", line[0], [], []))

        # This is an instruction line
        # First element is instr
        # Second is Args
        else:
            if ";" in line:
                tmp = line.index(";")
                Keywords = line[:tmp]
                Com = line[tmp:]
            else:
                Keywords = line
                Com = []
            
            if len(Keywords) == 0:
                output.append(Line("INSTR", [], [], Com))
            elif len(Keywords) == 1:
                output.append(Line("INSTR", Keywords[0], [], Com))
            else:
                output.append(Line("INSTR", Keywords[0], Keywords[1:], Com))

    # Then, get the max lengh for each type of keywords
    MaxInstrLen = 0
    MaxArg1Len = 0
    MaxArg2Len = 0

    for out in output:
        if len(out.Instr) > MaxInstrLen:
            MaxInstrLen = len(out.Instr)

        match len(out.Args):
            case 1:
                if len(out.Args[0]) > MaxArg1Len:
                    MaxArg1Len = len(out.Args[0])
            case 2:
                if len(out.Args[0]) > MaxArg1Len:
                    MaxArg1Len = len(out.Args[0])
                if len(out.Args[1]) > MaxArg2Len:
                    MaxArg2Len = len(out.Args[1])

    # Compute the wanted indent. Here we round to the upper multiple of 4 and add 4 to clarity
    InstrIndent = (ceil(MaxInstrLen / 4) * 4) + 4
    Arg1Indent = (ceil(MaxArg1Len / 4) * 4) + 4
    Arg2Indent = (ceil(MaxArg2Len / 4) * 4) + 4

    # Write the file to be correctly formatted
    with open(Input[:-4] + ".asm", "w+") as fout:
        for out in output:
            if out.Type == "INSTR":
                fout.write("    ")

            if out.Instr != []:
                fout.write(f"{str(out.Instr).ljust(InstrIndent)}")
            else:
                fout.write(f"{"".ljust(InstrIndent)}")

            match len(out.Args):
                case 0:
                    fout.write(f"{"".ljust(Arg1Indent)}{"".ljust(Arg2Indent)}")
                case 1:
                    fout.write(f"{str(out.Args[0]).ljust(Arg1Indent)}{"".ljust(Arg2Indent)}")
                case 2:
                    fout.write(f"{str(out.Args[0]).ljust(Arg1Indent)}{str(out.Args[1]).ljust(Arg2Indent)}")

            if out.Comments != []:
                for string in out.Comments:
                    fout.write(f"{str(string)} ")

            fout.write("\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="AssemblyFormatter",
        description="Format for Minted (Latex) use the inconsistent Microchip files"
    )
    parser.add_argument("input")
    parser.add_argument("-c", "--copy")

    args = parser.parse_args()
    if args.copy in ["True", "true", "y", "yes"]:
        Copy = True
    else:
        Copy = False

    Format(args.input, Copy)

    print("Done !")

