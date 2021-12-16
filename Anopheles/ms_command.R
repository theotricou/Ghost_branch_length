library('ape')
library('coala')
library('phyclust')
library('phangorn')
activate_ms(priority = 600)

model <- coal_model(sample_size = c(0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), loci_number = 1, loci_length = 1, ploidy = 1) +
feat_mutation(rate = 20.0, model = 'IFS', fixed_number = FALSE, locus_group = 'all') +
feat_pop_merge(2.4229225, 3, 2) +
feat_pop_merge(4.5339, 2, 1) +
feat_pop_merge(4.0499575, 5, 4) +
feat_pop_merge(0.6572725, 9, 8) +
feat_pop_merge(2.93144, 8, 7) +
feat_pop_merge(0.1498075, 13, 12) +
feat_pop_merge(0.06075, 17, 16) +
feat_pop_merge(0.1881325, 16, 15) +
feat_pop_merge(0.80138, 15, 14) +
feat_pop_merge(2.063195, 14, 12) +
feat_pop_merge(2.3404225, 12, 11) +
feat_pop_merge(3.516615, 11, 10) +
feat_pop_merge(4.2658175, 10, 7) +
feat_pop_merge(5.3139925, 7, 6) +
feat_pop_merge(5.41267, 6, 4) +
feat_pop_merge(6.385355, 4, 1) +
feat_pop_merge(1.848355, 20, 19) +
feat_pop_merge(4.77904, 23, 22) +
feat_pop_merge(5.1450675, 22, 21) +
feat_pop_merge(6.3984175, 21, 19) +
feat_pop_merge(9.3881025, 19, 18) +
feat_pop_merge(9.9674925, 26, 25) +
feat_pop_merge(3.9029425, 29, 28) +
feat_pop_merge(4.5547875, 28, 27) +
feat_pop_merge(1.9461975, 34, 33) +
feat_pop_merge(3.797115, 33, 32) +
feat_pop_merge(7.632915, 32, 31) +
feat_pop_merge(7.8196275, 31, 30) +
feat_pop_merge(8.9180625, 30, 27) +
feat_pop_merge(10.492755, 27, 25) +
feat_pop_merge(10.7184825, 25, 24) +
feat_pop_merge(11.08635, 24, 18) +
feat_pop_merge(12.5, 18, 1) +
sumstat_seg_sites() + sumstat_trees()


model_ingroup<-model +
feat_migration(80000.0, pop_from = 9, pop_to = 2, symmetric = FALSE, time = 0, locus_group = 'all') +
feat_migration(0, pop_from = 9, pop_to = 2, symmetric = FALSE, time = 2.5e-06, locus_group = 'all')


model_ghost<-model +
feat_migration(80000.0, pop_from = 29, pop_to = 9, symmetric = FALSE, time = 0, locus_group = 'all') +
feat_migration(0, pop_from = 29, pop_to = 9, symmetric = FALSE, time = 2.5e-06, locus_group = 'all')
