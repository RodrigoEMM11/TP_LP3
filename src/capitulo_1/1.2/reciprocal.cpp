#include <cassert>
#include "reciprocal.hpp"

double reciprocal (int i){
	//i no debe de ser cero
	assert(i != 0);
	return 1.0/i;
}
