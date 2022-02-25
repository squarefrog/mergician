//
//  Copyright © 2022 The Beans Group. All rights reserved.
//

import Foundation

extension UUID {
    static var testing: () -> UUID {
        { UUID(uuidString: "00000000-0000-0000-0000-000000000000")! }
    }
}
