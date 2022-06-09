test:
	docker-compose down
	docker-compose up -d

experiment0:
	cd ./jmeter/experiment_0 && bash ./run_expirement.sh

experiment1:
	cd ./jmeter/experiment_1 && bash run_expirement.sh

experiment2:
	cd ./jmeter/experiment_2 && bash run_expirement.sh

experiment3:
	cd ./jmeter/experiment_3 && bash run_expirement.sh

experiment4:
	cd ./jmeter/experiment_4 && bash run_expirement.sh

experiment5:
	cd ./jmeter/experiment_5 && bash run_expirement.sh

experiment6:
	cd ./jmeter/experiment_6 && bash run_expirement.sh

experiment7:
	cd ./jmeter/experiment_7 && bash run_expirement.sh

all:
	experiment0
	experiment1
	experiment2
	experiment3
	experiment4
	experiment5
	experiment6
	experiment7

all_5:
	END=5
	all

all_single:
	END=1
	all

all_10:
	END=10
	all
