# ViewModel
### Home Screen
```javascript
content {
    id: Int
    image: String
    title: String
    date: String
    voting: Int
}
 
 
section {
    title: String
    contents: [content]
}
```

### Detail Screen
```javascript
{
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
    title: String,
    image: String,
    director: String,
    player:[String],
    description: String,
    nowOn: [String]
    year: String
    voting: Int
    date: String
}
 
 
class Category {
    title: String,
    contents: [Content]
}
```
