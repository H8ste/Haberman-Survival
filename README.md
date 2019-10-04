# Haberman-Survival

Mini project assignment in the course Machine Learning for Media Technology where I pursue to to asses probability of survival in breast cancer patiants by developing a classifier based on the following input type:

|Age of patient at time of operation |Patient's year of operation| Number of positive axillary nodes detected| Survival status |
| ------------- |:-------------:| :-----:| ----: |
| 30 | 64 | 1 | 1 |
| ... | ... | ... | ... |
| 83 | 58 | 2 | 2 |

## Setup

Classification is written using MATLAB. However, the data provided is considered parsed. Therefore, the python file *parse_input.py* has to be run. No parameters are expected.

```python
python parse_input.py
```

This script parses input found in **/src/haberman.data** and normalizes: *Age of patient at time of operation*, *Patent's year of operation* and *Number of positive axillary nodes detected*. Furthermore, it converts the final input *Survival status* from 1 and 2 to 0 and 1.

The parsed data can then be found in **/src/parsed_src/parsed.data**.

## TODO

The following is a functionality list that are/yet to be implemented:

- [X] Parser (Python)
- [ ] Visualize parsed data (Matlab)
- [ ] Classifier (Matlab)
- [ ] Rewrite Parser (Matlab)
