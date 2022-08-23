{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}
module Models.User where

import Database.Persist.TH
import Data.Text

share [mkPersist sqlSettings] [persistLowerCase|
User sql=users
  email Text
  username Text
  UniqueEmail email
  UniqueUsername username
|]