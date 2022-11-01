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
cargo install lenra_cli --version=1.0.0-beta.5
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

The `server` directory is where all the boilerplate is stored. It creates and start the server that will serve your widget and listeners. You don't need to understand/change the code in this directory.
The `app` directory is where your app lives. You can add/remove/update files the way you want in this directory with some exceptions : 
- The `Manifest` module should only be updated to add/remove routes.
- The `Resources` module serve your static files (image mainly). Don't change this unless you want to serve files dynamically (generate images on the fly, get images from an outside server, etc.)

### Create your widgets

To create your widget, simply create a new module under lib/app/widgets (or anywher else, but stay organized !).
Then create a new function in this module and add the `@name` annotation to register and name your widget.
You also can bind the data and props arguments to struct using the `@data_struct` and `@props_struct` annotations respectively. Otherwise, they will be simple map.

You can then call your widget using the generated function in others widgets `MyWidget.new_<widget_name>()`.

Example : 
```elixir
defmodule App.Widgets.Counter do
  use Widgets

  alias App.Listeners.CounterListeners
  alias App.Counters.Counter
  alias App.Props.{Text, Id}

  @name "counter"
  @data_struct Counter
  @props_struct Text
  def counter_w([%Counter{} = counter], %Text{} = props, _context) do
    %{
      "children" => [
        %{"type" => "text", "value" => "#{props.text} : #{counter.value}"},
        %{
          "onPressed" => CounterListeners.new_increment(props: %Id{_id: counter._id}),
          "text" => "+",
          "type" => "button"
        }
      ],
      "crossAxisAlignment" => "center",
      "mainAxisAlignment" => "spaceEvenly",
      "spacing" => 2,
      "type" => "flex"
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