name := """Práctico 7"""

version := "1.24"

scalaVersion := "3.3.4"

libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.19" % "test"
libraryDependencies += "org.scalatestplus" %% "scalacheck-1-18" % "3.2.19.0" % "test"
run/fork := true
Test/logBuffered := false
autoAPIMappings := true
scalacOptions ++= Seq(
  "-source:future",
  "-feature",
  "-deprecation",
  "-explain",
  "-explain-types"
)
Compile/doc/scalacOptions ++= Seq(
  "-doc-root-content", 
  baseDirectory.value+"/root-doc.txt"
)
