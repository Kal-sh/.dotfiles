#!/bin/bash

echo "🚀 Starting all scripts at $(date)..."

run_script() {
  echo "⏱️ [$(date)] Starting 🚧 $1..."
  ./"$1"
  if [ $? -eq 0 ]; then
    echo "✅ [$(date)] Finished 🎉 $1."
  else
    echo "❌ [$(date)] $1 failed 😢"
  fi
}

run_script install_script.sh &
run_script install-flatpaks.sh &

wait
echo "🎯 All done at $(date)! 🎉"
