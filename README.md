<h1>Animal Founder</h1> 
<b>Endpoints para a requisicao na API</b>
<br>
<b>Usuarios</b>

"/sign_up": Requisicao Post para essa rota, cria um novo usuario no banco de dados com o seguinte JSON

```
{
	"user":{
		"name": string,
		"password": string,
		"password_confirmation": string,
		"email": string,
		"cellphone": string //(XX)XXXXX-XXXX
	}
}
```

“/login”: Requisições POST para essa rota com o seguinte JSON cria uma sessão para o usuário pedido, e retorna um token que deve ser armazenado para fazer as demais requisições, usando-o para autorizar as mesmas. 
```
{
	"user":{
		"email":string,
		"password":string
	}
}
```
