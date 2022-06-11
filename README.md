# Swift Wasm demo

## Build

```
swift build --triple wasm32-unknown-wasi  -c release -Xlinker --allow-undefined
```

## Copy Build result

```
cp .build/release/swiftwasm.wasm ./swiftwasm.wasm
```

## Strip (Optional)

Reduce size of wasm if you want

### Install WABT

```
brew install wabt
```

```
wasm-strip swiftwasm.wasm
```