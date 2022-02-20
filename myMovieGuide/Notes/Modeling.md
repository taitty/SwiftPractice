# View Data
### Home Screen
```javascript
content {
    id: Int
    image: String
    title: String
    year: String
    voting: Int
}
 
section {
    title: String
    [content]
}
```

### Detail Screen
```javascript
{
    id: Int
    title: String
    image: String
    director: String
    player: [String]
    description: String
    nowOn: [String]
}
```

# Entity
```javascript
class Content {
    id: Int
    title: String,
    image: String,
    director: String,
    player:[String],
    description: String,
    nowOn: [String]
}
 
 
class Category {
    title: String,
    contents: [Content]
}
```
