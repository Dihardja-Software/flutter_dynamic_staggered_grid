# Dynamic Staggered Grid
<p>
	<a href="https://pub.dev/packages/dynamic_staggered_grid" rel="noopener" target="_blank"><img src="https://img.shields.io/pub/v/dynamic_staggered_grid.svg" alt="Pub.dev Badge"></a>
	<a href="https://github.com/Dihardja-Software/flutter_dynamic_staggered_grid" rel="noopener" target="_blank"><img src="https://img.shields.io/badge/platform-flutter-ff69b4.svg" alt="Flutter Platform Badge"></a>
</p>

Dynamic staggered grid view

<p>
    <img src="https://raw.githubusercontent.com/Dihardja-Software/flutter_dynamic_staggered_grid/master/doc/assets/stagger_2_7.PNG" />
    <img src="https://raw.githubusercontent.com/Dihardja-Software/flutter_dynamic_staggered_grid/master/doc/assets/stagger_3_7.PNG" />
    <img src="https://raw.githubusercontent.com/Dihardja-Software/flutter_dynamic_staggered_grid/master/doc/assets/stagger_3_8.PNG" />
</p>

## Usage
```dart
  DynamicStaggeredGridView(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    crossAxisCount: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    itemHeight: 100,
    itemBuilder: (context, index) {
    var item = list[index];
      return Text(index);
    },
    itemCount: list.length,
  ),
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
