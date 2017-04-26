class Lexi
  # Palavras do analisador
  letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","X","W","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","x","w","y","z"]
  numbers = ["0","1","2","3","4","5","6","7","8","9"]
  comment = ["{","}","|","/"]
  end_string = ["\n"," ",";"]
  special = ["+","-","*","/",",",".","=","<","<=",">",">=",":",";","[","]",":=","...","<>"]
  reserved = ["const","div","or","and","not","if","then","else","of","while","do","begin","end","read","write","var","array","function","procedure","program","true","false","char","integer","boolean"]
  lexema = String.new
  puts "Entre com o texto a ser analisada:"
  input = "program programa1;
begin
@aux>=10.65;
end. "
  state = 0
  line = 0
  puts "#{input.split("")}"
    for character in input.split("")              #Percorre o input todo
      puts "#{character}, #{state},#{lexema}"
      #puts "linha #{line+1}"
      case state   # Verifica em que estado o automato está
        when 0
          if letters.include? character
            lexema << character
            state = 1
          elsif numbers.include? character
            lexema << character
            state = 2
          elsif character == "/"
            lexema << character
            state = 5
          elsif special.include? character
            lexema << character
            state = 6
          else
            puts "Caracter inválido #{character}"
          end
        when 1
          if special.include? character
            puts "Palavra Reservada #{lexema}"
            lexema = String.new
            lexema << character
            state = 6
          elsif (letters.include? character or numbers.include? character)
            lexema << character
          elsif  reserved.include? lexema and !(special.include? character)
            puts "Palavra Reservada #{lexema}"
            lexema = String.new
            state = 0
          elsif !(reserved.include? lexema)
            puts "Identificador #{lexema}"
            lexema = String.new
            state = 0
          end
        when 2
          if character == "."
            lexema << character
            state =3
          elsif special.include? character
            puts "Inteiro válido #{lexema}"
            lexema = String.new
            lexema << character
            state = 6
          elsif numbers.include? character
            lexema << character
          elsif end_string.include? character and (lexema.to_i).abs <= 4294967295
            puts "Inteiro Válido #{lexema}"
            lexema = String.new
            state = 0
          elsif end_string.include? character
            puts "OverFlow inteiro"
            lexema = String.new
            state = 0
          elsif character == "."
            lexema << character
            state =3
          end
        when 3
          if numbers.include? character
            lexema << character
            state = 4
          else
            puts "Real inválido #{lexema}"
            state = 0
          end
        when 4
          lexema << character
          if  (lexema.to_f).abs <= (3.4*(10**38))
            puts "Real Válido #{lexema}"
            lexema = String.new
            state = 0
          else
            puts "OverFlow Real #{lexema}"
            lexema = String.new
            state = 0
          end
        when 5
          lexema << character
          if lexema == "//"
            puts "comentario #{lexema}"
          else
            lexema = String.new
            state = 0
            break
          end
        when 6
          if special.include? character
          lexema << character
          elsif end_string.include? character or special.include? lexema
            puts "Simbolo Reservado #{lexema}"
            lexema = String.new
            lexema << character
            state = 0
          else
            puts "Simbolo invalido"
            lexema = String.new
            lexema << character
            state = 0
          end
        else
          puts "Error na entrada"
      end
    end
end
