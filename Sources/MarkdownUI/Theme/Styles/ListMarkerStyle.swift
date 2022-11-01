import SwiftUI

public struct ListMarkerStyle<Configuration> {
  var makeBody: (Configuration) -> AnyView

  public init<Body: View>(
    @ViewBuilder makeBody: @escaping (_ configuration: Configuration) -> Body
  ) {
    self.makeBody = { configuration in
      AnyView(makeBody(configuration))
    }
  }
}

public struct ListItemConfiguration {
  public var listLevel: Int
  public var itemNumber: Int
}

private enum Constants {
  static let minWidth = Font.TextStyle.body.pointSize * 1.5
  static let bulletFontSize = Font.TextStyle.body.pointSize / 3
}

extension ListMarkerStyle where Configuration == ListItemConfiguration {
  // MARK: - Numbers

  public static var decimal: ListMarkerStyle {
    ListMarkerStyle { configuration in
      Text("\(configuration.itemNumber).")
        .monospacedDigit()
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }

  public static var upperRoman: ListMarkerStyle {
    ListMarkerStyle { configuration in
      Text(configuration.itemNumber.roman + ".")
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }

  public static var lowerRoman: ListMarkerStyle {
    ListMarkerStyle { configuration in
      Text(configuration.itemNumber.roman.lowercased() + ".")
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }

  // MARK: - Bullets

  public static var disc: ListMarkerStyle {
    ListMarkerStyle { _ in
      SwiftUI.Image(systemName: "circle.fill")
        .font(.system(size: Constants.bulletFontSize))
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }

  public static var circle: ListMarkerStyle {
    ListMarkerStyle { _ in
      SwiftUI.Image(systemName: "circle")
        .font(.system(size: Constants.bulletFontSize))
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }

  public static var square: ListMarkerStyle {
    ListMarkerStyle { _ in
      SwiftUI.Image(systemName: "square.fill")
        .font(.system(size: Constants.bulletFontSize))
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }

  public static var discCircleSquare: ListMarkerStyle {
    ListMarkerStyle { configuration in
      let styles: [ListMarkerStyle] = [.disc, .circle, .square]
      styles[min(configuration.listLevel, styles.count) - 1]
        .makeBody(configuration)
    }
  }

  public static var dash: ListMarkerStyle {
    ListMarkerStyle { _ in
      Text("-")
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }
}

public struct TaskListItemConfiguration {
  public var isCompleted: Bool
}

extension ListMarkerStyle where Configuration == TaskListItemConfiguration {
  // MARK: - Tasks

  public static var checkmarkSquareFill: ListMarkerStyle {
    ListMarkerStyle { configuration in
      SwiftUI.Image(systemName: configuration.isCompleted ? "checkmark.square.fill" : "square")
        .symbolRenderingMode(.hierarchical)
        .imageScale(.small)
        .scaledMinWidth(Constants.minWidth, alignment: .trailing)
    }
  }
}
