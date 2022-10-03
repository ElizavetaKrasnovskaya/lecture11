import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Private properties
    private var isFirstLoad = true
    private var snakeHead = UIView()
    private var snake = UIView()
    private var meal = UIView()
    private var gameTimer: Timer?
    private var screenWidth = CGFloat()
    private var screenHeight = CGFloat()
    private var size = 30
    private var step = CGFloat(10)
    private var marginTop = 30
    private var cornerRadius = CGFloat(10)
    private var dir = "down"
    private var score = 0
    
    // MARK: - Override methods
    override func viewDidLayoutSubviews() {
        if isFirstLoad {
            initScreenSize()
            initView()
            isFirstLoad = false
        }
    }
    
    // MARK: - Private methods
    private func initScreenSize() {
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
    }
    
    private func initView() {
        gameTimer?.invalidate()
        
        createSnake()
        createMeal()
    }
    
    private func createSnake() {
        snakeHead.frame = CGRect(
            x: 0,
            y: marginTop,
            width: size,
            height: size
        )
        snakeHead.layer.cornerRadius = cornerRadius
        snakeHead.backgroundColor = .systemGreen
        snake.addSubview(snakeHead)
        view.addSubview(snake)
        
        initSwipeGesture()
    }
    
    private func initSwipeGesture() {
        addSwipeGesture(to: view, direction: .up)
        addSwipeGesture(to: view, direction: .down)
        addSwipeGesture(to: view, direction: .left)
        addSwipeGesture(to: view, direction: .right)
    }
    
    private func createMeal() {
        let coordinates = getRandomCoordinates()
        meal.frame = CGRect(
            x: coordinates.0,
            y: coordinates.1,
            width: size,
            height: size
        )
        meal.layer.cornerRadius = cornerRadius
        meal.backgroundColor = .yellow
        view.addSubview(meal)
    }
    
    private func createSnakeBody() {
        var coordinateX = snake.subviews.last?.frame.origin.x ?? CGFloat(0)
        var coordinateY = snake.subviews.last?.frame.origin.y ?? CGFloat(0)
        
        switch dir {
        case "up":
            coordinateY -= CGFloat(size)
        case "down":
            coordinateY += CGFloat(size)
        case "left":
            coordinateX += CGFloat(size)
        case "right":
            coordinateX -= CGFloat(size)
        default:
            return
        }
        
        let body = UIView()
        body.frame = CGRect(
            x: Int(coordinateX),
            y: Int(coordinateY),
            width: size,
            height: size
        )
        body.backgroundColor = .green
        body.layer.cornerRadius = cornerRadius
        
        snake.addSubview(body)
        view.addSubview(snake)
    }
    
    private func addSwipeGesture(to view: UIView, direction:UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveSprite))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func moveSprite(_ gestureRecognizer: UISwipeGestureRecognizer) {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if self.isGameOver() {
                self.showAlert()
            } else if self.isCoordinatesEqual() {
                self.createSnakeBody()
                self.createMeal()
                self.score += 1
            } else {
                switch gestureRecognizer.direction {
                case .up:
                    self.dir = "up"
                    self.snake.frame.origin.y -= self.step
                case .down:
                    self.dir = "down"
                    self.snake.frame.origin.y += self.step
                case .left:
                    self.dir = "left"
                    self.snake.frame.origin.x -= self.step
                case .right:
                    self.dir = "right"
                    self.snake.frame.origin.x += self.step
                default:
                    return
                }
            }
        }
    }
    
    private func isGameOver() -> Bool {
        var result = false
        if snake.frame.origin.x < 0
            || snake.frame.origin.y + CGFloat(size) < CGFloat(marginTop)
            || snake.frame.origin.x + CGFloat(size) + step >= screenWidth
            || snake.frame.origin.y + CGFloat(size) + step >= screenHeight {
            result = true
        }
        return result
    }
    
    private func isCoordinatesEqual() -> Bool {
        var result = false
        if meal.frame.origin.x == snake.frame.origin.x
            && meal.frame.origin.y - CGFloat(30) == snake.frame.origin.y {
            result = true
        }
        return result
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Game is over", message: "You score is \(score). You can start a new game", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true) {
            self.initView()
        }
    }
    
    private func getRandomCoordinates() -> (Int, Int) {
        let screenWidth = Int(view.frame.size.width - snakeHead.frame.size.width) - (size / 2)
        let screenHeight = Int(view.frame.size.height - snakeHead.frame.size.height)
        
        let x = (Int.random(in: 0..<screenWidth)) / 10 * 10
        let y = (Int.random(in: marginTop..<screenHeight)) / 10 * 10
        
        return (x, y)
    }
}
