# template-elixir
[Elixir](https://github.com/elixir-lang/elixir) template to boostrap Lenra app

## Get Started !

### Requirements*

- [x] docker
- [x] docker-compose
- [ ] buildkit
- [x] lenra_cli

_*Unchecked value is optional_


### How to install `lenra_cli`

You need to install the Lenra CLI to start the devtools that will show your app.

To download it, you can use cargo or download the binary via the [latest github release assets](https://github.com/lenra-io/lenra_cli/releases)

From cargo you need to run the following command :

```bash
cargo install lenra_cli
# or `cargo install lenra_cli@1.0.0-beta.5`
```

When installed you can run the binary file

```bash
lenra --version
```

### Building and debugging your app

To build your app, you can run the `lenra build` command that will build the docker container
```bash
lenra build
```

The `lenra start` command will start all needed services to make your app ready and then open your browser so you can start debugging.

```bash
lenra start
```

When everything is fine, you can stop your app by running the `lenra stop` command. That will interrupt all current running services about your app. And delete all data from your app to be able to keep your test clean.

```bash
lenra stop
```


## Using the Elixir template

The `lib/app` directory is where your app lives.
- `lib/app/views` contains your views. Run `mix lenra.gen.view <ViewName>` to create a new view
- `lib/app/listeners` contains your listeners. Run `mix lenra.gen.listener <ListenerModule> [<listener>...]` to create a new listener module.
- 

### Create your views
Run `mix lenra.gen.view <ViewName>` to create a new view, this will generate a the view `lib/app/views/view_name.ex`.
Each View Module define only one view : You can only call the `defview` macro once per module.

You can then eather call your view directly using `App.Views.MyView.c/1` or create a ref to it using `App.Views.MyView.r/0`

Example : 
```elixir
defmodule App.Views.Counter do
  use Lenra.Views

  alias App.Listeners.CounterListeners
  alias App.Counters.Counter
  alias App.Props.{Text, Id}

  defview %{data: _data_, props: _props} do
    %{
      "type" => "text",
      "value" => "Hello World"
    }
  end
end
```

### Create your Listeners
Same principle with the listeners. Simply create your module under the `lib/app/listeners` directory.
Then create a new function with the `@action` annotation to register and name your listener.
Same thing with the listeners, you can bind the props argument using the `@props_struc` annotation.

Example :
```elixir
defmodule App.Listeners.CounterListeners do
  use Listeners
  alias App.Props.Id

  @action "increment"
  @props_struct Id
  def increment(%Id{} = props, _event, api) do
    App.Counters.increment(api, props._id)
  end
end
```

### The data API 
In your listener, you will want to call the Data API to change your model.
To do this, use the `Api.DataApi` module.

You can bind the return value of the data API into a struct to have typed value. To do this, simply add the `as: MyStruct` option.

Example : 
```elixir
Api.DataApi.get_doc(api, "counters", id, as: App.Counters.Counter)
```