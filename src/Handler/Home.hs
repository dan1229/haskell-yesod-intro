module Handler.Home
    ( getHomeR
    ) where

import Foundation
import Models.User
import Yesod 
import Data.Text (Text)
import GHC.Generics
import Orphans ()

data ApiUser = ApiUser
    { id :: Key User
    , email :: Text
    , username :: Text
    }
    deriving stock Generic
    deriving anyclass ToJSON


toApiUser :: Entity User -> ApiUser
toApiUser (Entity userId User {..}) =
    ApiUser
        { id = userId
        , email = userEmail
        , username = userUsername
        }

-- import [A]
getHomeR :: Handler [ApiUser]
getHomeR = runDB $ map toApiUser <$> selectList [] []