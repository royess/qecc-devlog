using QuantumClifford.ECC

function load_matrix_from_txt(filename)
    open(filename, "r") do io
        num_rows = countlines(io)
        seek(io, 0)
        first_line = readline(io)
        num_cols = length(split(first_line))
        matrix = zeros(Int, num_rows, num_cols)
        row_index = 1
        for line in eachline(io)
            values = parse.(Int, split(line))
            matrix[row_index, 1:num_cols] = values
            row_index += 1
        end
        return matrix
    end
end

# Example usage
hx = load_matrix_from_txt("lp04_7x.txt")
hz = load_matrix_from_txt("lp04_7z.txt")

code = CSS(hx, hz)

naive_encoding_circuit(code)

naive_syndrome_circuit(code)
