module Foundation where

import Data.Pool
import Database.Persist.Postgresql
import Yesod

    
mkYesodData "App" [parseRoutes|
/ HomeR GET
|]

class Monad (YesodDB site) => YesodPersist site where
    type YesodPersistBackend site
    runDB :: YesodDB site a -> HandlerFor site a


instance YesodPersist App where
  type YesodPersistBackend App = SqlBackend
  runDB action = do
    pool <- getsYesod appConnectionPool
    runSqlPool action pool



newtype App = App { appConnectionPool :: Pool SqlBackend, appSettings :: AppSettings }

    
instance Yesod App
