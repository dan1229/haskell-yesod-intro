


appMain :: IO ()
appMain = do
  args <- getArgs
  case args of
    ["--help"] -> putStrLn usage
    ["--version"] -> putStrLn version
    ["--license"] -> putStrLn license