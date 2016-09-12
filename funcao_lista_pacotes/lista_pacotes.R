# usando search() em uma nova sessao R retorna quais pacotes estao carregados 
# Carregados por padrao:
# "package:stats"     "package:graphics" 
# "package:grDevices" "package:utils"     "package:datasets" 
# "package:methods"   "package:base"  

# Outros que sao bem uteis, mas que voce precisa carregar:
# gplots
# ggplot2, reshape, plyr

listaPacotes <- function (packageName) {

    # Obtem uma lista de objetos de um pacote em particular
    funlist <- objects(packageName)

    # Remove things that don't start with a letter
    idx <- grep('^[a-zA-Z][a-zA-Z0-9._]*', funlist)
    funlist <- funlist[idx]

    # Remove tudo que contem seta invertida <-
    idx <- grep('<-', funlist)
    if (length(idx)!=0)
        funlist <- funlist[-idx]

    # Faz um dataframe manter seu status
    objectlist <- data.frame(name=funlist,
                             primitive=FALSE,
                             func=FALSE,
                             object=FALSE,
                             constant=FALSE,
                             stringsAsFactors=F)

    for (i in 1:nrow(objectlist)) {
        fname <- objectlist$name[i]
        if (exists(fname)) {
            obj <- get(fname)
            if (is.primitive(obj)) {
                objectlist$primitive[i] <- TRUE
            }
            if (is.function(obj)) {
                objectlist$func[i] <- TRUE
            }
            if (is.object(obj)) {
                objectlist$object[i] <- TRUE
            }
            
            # I think these are generally constants
            if (is.vector(obj)) {
                objectlist$constant[i] <- TRUE
            }
           
        
        }  
    }

    cat(packageName)
        
    cat("\n================================================\n")
    cat("Primitive functions: \n")
    cat(objectlist$name[objectlist$primitive])
    cat("\n")

    cat("\n================================================\n")
    cat("Non-primitive functions: \n")
    cat(objectlist$name[objectlist$func  &  !objectlist$primitive])
    cat("\n")

    cat("\n================================================\n")
    cat("Constants: \n")
    cat(objectlist$name[objectlist$constant])
    cat("\n")

    cat("\n================================================\n")
    cat("Objects: \n")
    cat(objectlist$name[objectlist$object])
    cat("\n")
}


# Exemplo da funcao usando o pacote base
listaPacotes("package:base")

