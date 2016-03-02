main {
	thisOplModel.generate();
	cp.startNewSearch();
	solutions = 0;
	while (cp.next()) {
		thisOplModel.postProcess();
		solutions++;
	}

	writeln("===== NB SOLUTIONS = ", solutions);
}
