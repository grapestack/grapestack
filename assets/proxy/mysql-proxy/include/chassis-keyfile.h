/* $%BEGINLICENSE%$
 Copyright (c) 2007, 2009, Oracle and/or its affiliates. All rights reserved.

 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License as
 published by the Free Software Foundation; version 2 of the
 License.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 02110-1301  USA

 $%ENDLICENSE%$ */
 

#ifndef _CHASSIS_KEYFILE_H_
#define _CHASSIS_KEYFILE_H_

#include <glib.h>

#include "chassis-exports.h"

/** @addtogroup chassis */
/*@{*/
/**
 * parse the configfile options into option entries
 *
 */
CHASSIS_API int chassis_keyfile_to_options(GKeyFile *keyfile, const gchar *groupname, GOptionEntry *config_entries);
CHASSIS_API int chassis_keyfile_resolve_path(const char *base_dir, GOptionEntry *config_entries);

/*@}*/

#endif

