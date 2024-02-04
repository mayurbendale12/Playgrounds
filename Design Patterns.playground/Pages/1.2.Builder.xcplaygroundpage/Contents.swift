//: ## Example 1
struct Article {
    let title: String
    let subtitle: String
}

class ArticleBuilder: CustomStringConvertible {
    private var title: String = ""
    private var subtitle: String = ""

    @discardableResult
    func withTitle(_ title: String) -> Self {
        self.title = title
        return self
    }

    @discardableResult
    func withSubTitle(_ subtitle: String) -> Self {
        self.subtitle = subtitle
        return self
    }

    func build() -> Article {
        return Article(title: title, subtitle: subtitle)
    }

    var description: String {
        return "Created Article with Title: \(title) and subtitle: \(subtitle)"
    }
}

let article = ArticleBuilder()
                .withTitle("test")
                .withSubTitle("dummy")
                .build()
print(article)

//: ## Example 2

final class DeathStarBuilder {
    var x: Double?
    var y: Double?
    var z: Double?

    typealias BuilderClosure = (DeathStarBuilder) -> ()

    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}

struct DeathStar: CustomStringConvertible {
    let x: Double
    let y: Double
    let z: Double

    init?(builder: DeathStarBuilder) {
        if let x = builder.x, let y = builder.y, let z = builder.z {
            self.x = x
            self.y = y
            self.z = z
        } else {
            return nil
        }
    }

    var description: String {
        return "Death Star at (x: \(x) y: \(y) z: \(z))"
    }
}

let empire = DeathStarBuilder { builder in
    builder.x = 0.1
    builder.y = 0.2
    builder.z = 0.3
}

let deathStar = DeathStar(builder: empire)!
print(deathStar)
