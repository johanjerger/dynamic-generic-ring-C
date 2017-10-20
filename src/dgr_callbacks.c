#include <stdlib.h>
#include <stdbool.h>
#include "includes/dynamic_generic_ring.h"

void dgr_set_equals_callback(ring_t * act_ring, bool (*equals_callback)(void *, void *))
{
        ring_t * head = act_ring;

        while(head->next != act_ring) {
                head->equals_callback = equals_callback;
                head = head->next;
        }

        head->equals_callback = equals_callback;
}

void dgr_set_print_callback(ring_t * act_ring, void (*print_callback)(void *))
{
        ring_t * head = act_ring;

        while(head->next != act_ring) {
                head->print_callback = print_callback;
                head = head->next;
        }

        head->print_callback = print_callback;
}
