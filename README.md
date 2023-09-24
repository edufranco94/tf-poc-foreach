#POC DE MIGRAÇÃO DE SERVIÇOS EM LIST PARA ESTRUTURA FOR_EACH


Objetivo:
Realizar refactoring do código terraform, migrando estrutura de uso "count" para estrutura de provisionamento "for_each" sem causar indisponibilidade em produção.


Contexto:
Quando se cria um projeto terraform, uma das principais perguntas é sobre qual a melhor forma de estruturar este projeto, pensando sempre em reuso e escalabilidade do código.
Dito isso, quando você tem um módulo, a ideia principal é fazer reuso deste para não duplicar linhas de código desnecessárias. Pensando nisso, o código foi desenvolvido inicialmente para provisionar três filas SQS na AWS.
Cada fila tera o mesmo nome, mudando somente o sulfixo por ambiente, veja os exemplos abaixo:
Padrão: ${sqs_name}-{ambiente}.
Filas : ["sqs-poc-dev", "sqs-poc-qa", "sqs-poc-uat"].


Problema:
Um código desenvolvido que usa um child module para provisionar qualquer recurso, utilizando o parametro "count" pode ser muito útil quando você entrega aquela infraestrutura e ela não se modifica mais!
Porém, quando sua infraestrutura precisa de modificações pontuais e/ou recorrente, o count pode vir se tornar um problema. Isso acontece porque a estrutura de count monta uma lista ordenada de recursos, onde, qualquer tipo de modificação nesta lista, pode gerar comportamentos inesperado por parte do terraform, como por exemplo, destruir e recriar o seu recurso.
E é por isso que foi necessário desvincular os recursos desta lista, migrando para uma estrutura mais modular como por exemplo um mapa de objetos de string.


Desafios:
Modificar lógica interna no module child (trocando o "count" por "for_each");
Modificar parametros passados para o root module;
Modificar tipo de variáveis que compõe o código como um todo;
Não utilizar "terraform destroy";
Realizar "terraform apply", sem mudanças e impactos na infraestrutura;
Não causar indisponibilidade dos serviços;


Resolução:
Manipular arquivo de estado manualmente pode ser extremamente perigoso se não for feito com cautela, e para isso, minha sugestão inicial é sempre realizar um backup antes de fazer essa ação.
O código foi modificado de acordo com os desafios listados acima, e quando pronto, utilizamos o recurso "terraform state mv", link: https://developer.hashicorp.com/terraform/cli/commands/state/mv.
Este comando, permite que você movimente estrutura de dados do seu arquivo de estado terraform, de uma forma inteligente, sem causar qualquer tipo de incompatibilidade para o terraform. Não se preocupe, o terraform irá se responsabilizar em corrigir todo arquivo .json para a estrutura correta, e isso vai depender muito de como você vai migrar seus recursos, vejam estes exemplos abaixo:
- terraform state mv module.sqs_test.aws_sqs_queue.terraform_queue[0] module.sqs_test.aws_sqs_queue.terraform_queue["\poc-edu-dev\"]
- terraform state mv module.sqs_test.aws_sqs_queue.terraform_queue[1] module.sqs_test.aws_sqs_queue.terraform_queue[\"poc-edu-qa\"]
- terraform state mv module.sqs_test.aws_sqs_queue.terraform_queue[2] module.sqs_test.aws_sqs_queue.terraform_queue[\"poc-edu-uat\"]
Nestes exemplos, migramos estrutura em lista, para estrutura em mapa.
