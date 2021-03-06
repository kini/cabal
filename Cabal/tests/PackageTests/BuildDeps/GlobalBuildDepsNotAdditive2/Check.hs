module PackageTests.BuildDeps.GlobalBuildDepsNotAdditive2.Check where

import Test.HUnit
import PackageTests.PackageTester
import System.FilePath
import Data.List
import Control.Exception
import Prelude hiding (catch)


suite :: FilePath -> Test
suite ghcPath = TestCase $ do
    let spec = PackageSpec ("PackageTests" </> "BuildDeps" </> "GlobalBuildDepsNotAdditive2") []
    result <- cabal_build spec ghcPath
    do
        assertEqual "cabal build should fail - see test-log.txt" False (successful result)
        let sb = "Could not find module `Prelude'"
        assertBool ("cabal output should be "++show sb) $
            sb `isInfixOf` outputText result
      `catch` \exc -> do
        putStrLn $ "Cabal result was "++show result
        throwIO (exc :: SomeException)
