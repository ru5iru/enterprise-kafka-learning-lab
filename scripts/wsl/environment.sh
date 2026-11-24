# Source from lab.sh or a WSL Bash session; does not edit shell startup files.
export JAVA_HOME="${LAB_JAVA_HOME:-/opt/kafka-lab/jdk-25.0.5.1}"
if [[ ! -x "$JAVA_HOME/bin/java" || ! -x "$JAVA_HOME/bin/javac" ]]; then
  printf 'Invalid Linux JDK: set LAB_JAVA_HOME to a complete installed JDK.\n' >&2
  return 1
fi
export PATH="$JAVA_HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export MAVEN_HOME='/opt/kafka-lab/apache-maven-3.10.2'
export PATH="$MAVEN_HOME/bin:$PATH"
