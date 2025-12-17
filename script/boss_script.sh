#!/bin/bash

echo "Starting all scripts at $(date)..."

run_script() {
  echo "[$(date)] Starting $1..."
  ./"$1"
  echo "[$(date)] Finished $1."
}

run_script script1.sh &
run_script script2.sh &
run_script script3.sh &

wait
echo "All done at $(date)!"
#!/bin/bash

echo "Starting all scripts at $(date)..."

run_script() {
  echo "[$(date)] Starting $1..."
  ./"$1"
  echo "[$(date)] Finished $1."
}

run_script install_script.sh &
run_script install-flatpaks.sh &

wait
echo "All done at $(date)!"
