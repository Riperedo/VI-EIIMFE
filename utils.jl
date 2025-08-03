# ---------- saving data function ---------------

using DelimitedFiles

@doc """
    save_data(filepath::String, data_matrix::AbstractMatrix; 
              header_lines::Vector{String}=String[], 
              delimiter::Char='\\t', 
              print_confirmation::Bool=true)

Guarda una matriz de datos en un archivo de texto delimitado (formato .dat).
Cada columna de `data_matrix` se escribirá como una columna en el archivo.

# Arguments
- `filepath::String`: Ruta completa y nombre del archivo donde se guardarán los datos (ej. "resultados/datos_simulacion.dat").
- `data_matrix::AbstractMatrix`: Matriz de datos a guardar. Se espera que los datos estén organizados en columnas.

# Keywords
- `header_lines::Vector{String}=String[]`: Un vector de cadenas de texto. Cada cadena se escribirá como una línea de cabecera
  al inicio del archivo, prefijada con "# ". Por defecto, no se escribe ninguna cabecera.
- `delimiter::Char='\\t'`: El carácter delimitador a usar entre columnas. Por defecto, es un tabulador (`'\\t'`).
  Puedes usar otros como espacio (`' '`), coma (`','`), etc.
- `print_confirmation::Bool=true`: Si es `true`, imprime un mensaje de confirmación después de guardar el archivo.

# Example
```julia
x = collect(1.0:0.1:10.0)
y1 = sin.(x)
y2 = cos.(x)
# Guardar x, y1, y2 como tres columnas separadas por tabuladores
save_data("ejemplo.dat", [x y1 y2], 
          header_lines=["Columna 1: x", "Columna 2: sin(x)", "Columna 3: cos(x)"],
          delimiter='\\t')

# Guardar sin cabecera y con espacio como delimitador
z = x.^2
save_data("otro_ejemplo.dat", [x z], delimiter=' ')
```

# Notes
- La función usa `DelimitedFiles.writedlm`.
- Si el archivo especificado en `filepath` ya existe, será sobrescrito.
"""
function save_data(filepath::String, 
                   data_matrix::AbstractMatrix; 
                   header_lines::Vector{String}=String[], 
                   delimiter::Char='\t', 
                   print_confirmation::Bool=true)
    
    try
        open(filepath, "w") do io
            # Escribir las líneas de cabecera, si las hay
            if !isempty(header_lines)
                for header_line in header_lines
                    write(io, "# ") # Prefijo estándar para comentarios/cabeceras
                    write(io, header_line)
                    write(io, "\n") # Nueva línea después de cada línea de cabecera
                end
            end
            
            # Escribir los datos usando el delimitador especificado
            writedlm(io, data_matrix, delimiter)
        end
        
        if print_confirmation
            println("Datos guardados exitosamente en: ", filepath)
        end
        
    catch e
        println(stderr, "Error al guardar el archivo '$filepath':")
        showerror(stderr, e)
        println(stderr) # Añade una nueva línea después del error
        # Opcionalmente, podrías relanzar el error si prefieres que la función falle explícitamente
        # rethrow(e)
    end
end