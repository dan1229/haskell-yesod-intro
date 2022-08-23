{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Orphans where

import Data.Aeson
import Yesod


-- need both these instances to be a response in a handler
instance {-# OVERLAPPABLE #-} ToJSON a => ToTypedContent a where
    toTypedContent = TypedContent typeJson . toContent

instance {-# OVERLAPPABLE #-} ToJSON a => ToContent a where
    toContent = toContent . encode
-- END