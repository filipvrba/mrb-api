# Mrb API
The "*vweb*" module of the V programming language is used in this project.
The project uses *HTTP* to communicate with *MRuby*, which is implemented. 

### Content
- [1 Usage](#1-usage)
  - [1.1 Token](#11-token)
  - [1.2 Example](#12-example)
- [2 Development](#2-development)
- [3 Examples](#3-examples)
- [4 Contributors](#4-contributors)

## 1 Usage
This *API* can be used by entering a *URL* to access it.
The application's *API* host name must be present in the link *URL*,
followed by an access token and a *Ruby* script.

> ### Info
> A public web application is Mrb API.
> To access it, enter the URL **https://mrbapi.fly.dev/**.

### 1.1 Token
There is no requirement to register anyplace, and the access token is public.

*The access token is as follows:*
```txt
kfj1T7dh3ena17yG0xGoeH7Y1983wybJpcBNP6j1
```

### 1.2 Example
I'll give the command that gets the output of a
*Ruby* script in json format as an illustration. 

*Here is the command:*
```bash
curl "https://mrbapi.fly.dev/?token=kfj1T7dh3ena17yG0xGoeH7Y1983wybJpcBNP6j1&mrb='foo'.capitalize" | json_pp
```

*The terminal displays the following outcome:*
```txt
{
    "code" : "Result",
    "mrb_code" : "'foo'.capitalize",
    "result" : "Foo"
}
```

## 2 Development
The way this project was created makes it available to anyone who knows the *URL* link.
As a result, it is uploaded using *Docker* to [fly.io](https://fly.io/).
My goal is to help folks understand how *MRuby* might be used in this *API* project.
I advise everyone who is interested in this particular project to read the *API Develop* article.
The article talks about using *MRuby* to provide a simpler *API*.

*The article is available here:*
- [**API Develop**](/docs/en-api_develop.md)

## 3 Examples
Several projects may be found here that utilize the *MRB API*
to further handle the result *string* from the *Ruby script*.

- [Edu Game](https://github.com/filipvrba/edu-game-rjs) - An instructional game that teaches players how to develop Ruby scripts in an interactive manner.

## 4 Contributors
- [Filip Vrba](https://github.com/filipvrba) - creator and maintainer
